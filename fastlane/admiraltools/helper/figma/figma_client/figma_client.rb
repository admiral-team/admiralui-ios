# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'
require_relative 'models/models'

class FigmaClient
  TOKEN_HEADER_NAME = 'X-FIGMA-TOKEN'
  CONTENT_TYPE_HEADER_NAME = 'Content-Type'
  CONTENT_TYPE_HEADER_VALUE = 'application/json'
  BASE_URL_DEFAULT = 'https://api.figma.com/v1'

  def initialize(access_token:, base_url: nil)
    @access_token = access_token
    @base_url = base_url || BASE_URL_DEFAULT
  end

  def get_full_image_components(
    file_key:,
    image_format:,
    scales:,
    name_filter_regex:,
    desc_filter_regex: nil,
    frame_filter_regex: nil,
    page_filter_regex: nil,
    request_batch: nil,
    svg_include_id: nil,
    svg_simplify_stroke: nil,
    use_absolute_bounds: nil
  )
    converter = FigmaToDomainConverter.new
    components_result = get_components(file_key: file_key)
    figma_components = components_result&.meta&.components || []
    scales = [1.0] if scales.nil? || scales.empty?

    unless name_filter_regex.nil?
      figma_components = figma_components.select { |c| c.name[Regexp.new(name_filter_regex)] }
    end

    unless desc_filter_regex.nil?
      figma_components = figma_components.select { |c| c.description[Regexp.new(desc_filter_regex)] }
    end

    unless frame_filter_regex.nil?
      figma_components = figma_components.select { |c| c.containing_frame&.name[Regexp.new(frame_filter_regex)] }
    end

    unless page_filter_regex.nil?
      figma_components = figma_components.select { |c| c.containing_frame&.page_name[Regexp.new(page_filter_regex)] }
    end

    node_ids = figma_components.map(&:node_id)
    node_id_batches = node_ids.each_slice(request_batch || 1_000_000).to_a
    image_links_hash = {}

    scales.each do |scale|
      images_all = {}
      node_id_batches.each do |batch_node_ids|
        images = get_images(
          file_key: file_key,
          node_ids: batch_node_ids,
          image_format: image_format,
          scale: scale,
          svg_include_id: svg_include_id,
          svg_simplify_stroke: svg_simplify_stroke,
          use_absolute_bounds: use_absolute_bounds
        )&.images || {}
        puts batch_node_ids
        puts svg_include_id
        images_all.merge!(images)
      end
      image_links_hash[scale] = images_all
    end

    components = converter.fulfill_components(
      figma_components: figma_components,
      image_links_hash: image_links_hash,
      image_format: image_format
    )

    ComponentsList.new(components: components)
  end

  def get_components(file_key:)
    uri = URI.parse("#{@base_url}/files/#{file_key}/components")

    req = create_request(uri)
    http = create_http_client(uri)

    res = http.start do |h|
      h.request(req)
    end

    raise "HTTP Status Code: #{res.code}\n#{res.body}" unless res.is_a?(Net::HTTPSuccess)

    json_data = JSON.parse(res.body)
    FigmaComponentsStylesResult.from_hash(json_data)
  end

  def get_images(file_key:, node_ids:, image_format:, scale:, use_absolute_bounds:, svg_include_id:, svg_simplify_stroke:)
    uri = URI.parse("#{@base_url}/images/#{file_key}")
    params = {}
    params['ids'] = node_ids.join(',')
    params['format'] = image_format unless image_format.nil?
    params['scale'] = scale unless scale.nil?
    params['use_absolute_bounds'] = use_absolute_bounds unless use_absolute_bounds.nil?
    params['svg_include_id'] = svg_include_id unless svg_include_id.nil?
    params['svg_simplify_stroke'] = svg_simplify_stroke unless svg_simplify_stroke.nil?
    add_query_parameters(uri: uri, params: params)

    req = create_request(uri)
    http = create_http_client(uri)

    res = http.start do |h|
      h.request(req)
    end

    raise "HTTP Status Code: #{res.code}\n#{res.body}" unless res.is_a?(Net::HTTPSuccess)

    json_data = JSON.parse(res.body)
    FigmaImagesResult.from_hash(json_data)
  end

  def get_full_styles(file_key:, request_batch:)
    converter = FigmaToDomainConverter.new
    styles_result = get_styles(file_key: file_key)
    node_ids = (styles_result&.meta&.styles || []).map(&:node_id)
    node_id_batches = node_ids.each_slice(request_batch || 1_000_000).to_a

    nodes_result = FigmaNodesResult.new(name: nil, nodes: {})

    node_id_batches.each do |batch_node_ids|
      result = get_nodes(file_key: file_key, node_ids: batch_node_ids, depth: 1)
      nodes_result.name = result.name
      nodes_result.nodes.merge!(result.nodes)
    end

    converter.fulfill_styles(figma_nodes_result: nodes_result, figma_styles_result: styles_result)
  end

  def get_styles(file_key:)
    uri = URI.parse("#{@base_url}/files/#{file_key}/styles")

    req = create_request(uri)
    http = create_http_client(uri)

    res = http.start do |h|
      h.request(req)
    end

    raise "HTTP Status Code: #{res.code}\n#{res.body}" unless res.is_a?(Net::HTTPSuccess)

    json_data = JSON.parse(res.body)
    FigmaComponentsStylesResult.from_hash(json_data)
  end

  def get_nodes(file_key:, node_ids:, depth: 1)
    uri = URI.parse("#{@base_url}/files/#{file_key}/nodes")
    node_ids_string = node_ids.join(',')
    params = { "ids": node_ids_string, "depth": depth }
    add_query_parameters(uri: uri, params: params)

    req = create_request(uri)
    http = create_http_client(uri)

    res = http.start do |h|
      h.request(req)
    end

    raise "HTTP Status Code: #{res.code}\n#{res.body}" unless res.is_a?(Net::HTTPSuccess)

    json_data = JSON.parse(res.body)
    FigmaNodesResult.from_hash(json_data)
  end

  private

  def add_query_parameters(uri:, params:)
    uri.query = URI.encode_www_form(URI.decode_www_form(uri.query || '').concat(params.to_a))
  end

  def create_request(uri)
    req = Net::HTTP::Get.new(uri.request_uri.to_s)
    req[CONTENT_TYPE_HEADER_NAME] = CONTENT_TYPE_HEADER_VALUE
    req[TOKEN_HEADER_NAME] = @access_token
    req
  end

  def create_http_client(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http
  end
end
