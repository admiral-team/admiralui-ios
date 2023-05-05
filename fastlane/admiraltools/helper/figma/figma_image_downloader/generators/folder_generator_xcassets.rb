# frozen_string_literal: true

require 'json'
require_relative 'folder_generator'
require_relative '../../helpers/hash_access'
require_relative '../helpers/scale_formatter'
require_relative '../helpers/image_name_formatter'
require_relative '../models/image_set_ref'

class FolderGeneratorXcassets < FolderGenerator

  attr_accessor :symbols

  def initialize(symbols:, params:)
    @symbols = symbols
    super(params: params)
  end

  def start_download(image_sets:)
    create_root_content_json(folder: params.output_folder)
  end

  def image_set_start_download(image_set:)
    create_recursive_asset_contnet_json(folder: image_set.folder)

    if symbols
      create_symbolset_content_json(image_set: image_set)
    else
      create_imageset_content_json(image_set: image_set)
    end
  end

  def image_end_download(image:)
    return unless params.convert_svg_to_vector

    input_file = File.join(params.output_folder, image.path)
    SvtToVectorConverter.new.convert(input_file: input_file)
  end

  def create_image_sets(image_component:)
    name_components = format_name(image_component: image_component)
    name = name_components.name
    extension = symbols ? 'symbolset' : 'imageset'
    folder = File.join(name_components.folder, "#{name}.#{extension}")

    image_links = image_component.image_links
    single_scale = image_component.single_scale?

    image_refs = image_links.map do |i|
      file_name = image_path(group_name: name, image_link: i, single_scale: single_scale)
      item_path = File.join(folder, file_name)
      ImageRef.new(path: item_path, image_link: i)
    end

    ImageSetRef.new(name: name, folder: folder, image_refs: image_refs, single_scale: single_scale)
  end

  private

  def create_root_content_json(folder:)
    file_path = File.join(folder, 'Contents.json')
    return if File.exist?(file_path)

    content = content_template
    File.write_file_json(path: file_path, hash: content)
  end

  def create_recursive_asset_contnet_json(folder:)
    folder_root = params.output_folder

    folders = folder.split('/')[0...-1].map do |f|
      folder_root = File.join(folder_root, f)
      folder_root
    end

    folders.each { |f| create_asset_contnet_json(folder: f) }
  end

  def add_content_property(content:, key:, value:)
    if content.dig('properties', key).nil? && !value.nil?
    properties = content['properties'] || {}
    properties[key] = value
    content['properties'] = properties
    end
  end

  def create_asset_contnet_json(folder:)
    file_path = File.join(folder, 'Contents.json')
    content = File.read_file_json(path: file_path) || content_template
    xcassets_params = params.xcassets_params || {}
    provides_namespace = xcassets_params[:provides_namespace]

    add_content_property(content: content, key: 'provides-namespace', value: provides_namespace)

    File.write_file_json(path: file_path, hash: content)
  end

  def content_template
    content = {}
    content['info'] = {}
    content['info']['version'] = 1
    content['info']['author'] = 'xcode'
    content
  end

  def create_symbolset_content_json(image_set:)
    image_refs = image_set&.image_refs || []

    if image_refs.empty?
      return
    end

    folder = File.join(params.output_folder, image_set.folder)
    file_path = File.join(folder, 'Contents.json')
    content = File.read_file_json(path: file_path) || content_template
    symbols = content['symbols'] || []

    ref = image_refs[0]
    filename = File.basename(ref.path)

    symbol = symbols.first || {}
    symbol['filename'] = filename
    symbol['idiom'] = 'universal' if symbol['idiom'].nil?

    symbols = [symbol]
    content['symbols'] = symbols

    xcassets_params = params.xcassets_params || {}
    language_direction = xcassets_params[:language_direction]
    add_content_property(content: content, key: 'language-direction', value: language_direction)

    File.write_file_json(path: file_path, hash: content)
  end

  def create_imageset_content_json(image_set:)
    folder = File.join(params.output_folder, image_set.folder)
    file_path = File.join(folder, 'Contents.json')
    content = File.read_file_json(path: file_path) || content_template
    images = content['images'] || []

    image_set&.image_refs&.each do |task|
      filename = File.basename(task.path)
      image_names = images.map { |i| i['filename'] }.compact
      image_index = image_names.find_index(filename)

      if image_index.nil?
        images.push({})
        image_index = images.length - 1
      end

      image = images[image_index]

      image['filename'] = filename
      image['idiom'] = 'universal' if image['idiom'].nil?

      scale = task.image_link.scale
      scale_enabled = !scale.nil? && !image_set.single_scale

      if scale_enabled
        image['scale'] = ScaleFormatter.new.formatted_scale(scale: scale)
      else
        image.delete('scale')
      end
    end

    content['images'] = images
    xcassets_params = params.xcassets_params || {}
    template_rendering_intent = xcassets_params[:template_rendering_intent]
    preserves_vector_representation = xcassets_params[:preserves_vector_representation]

    add_content_property(content: content, key: 'template-rendering-intent', value: template_rendering_intent)
    add_content_property(content: content, key: 'preserves-vector-representation', value: preserves_vector_representation)

    File.write_file_json(path: file_path, hash: content)
  end

end



