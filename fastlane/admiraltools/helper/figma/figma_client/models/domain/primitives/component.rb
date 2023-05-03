# frozen_string_literal: true

require_relative 'image_link'
require_relative 'frame_info'

class Component
  attr_accessor \
    :key,
    :file_key,
    :node_id,
    :name,
    :description,
    :containing_frame,
    :image_links

  def single_scale?
    links = image_links || []
    return false if links.length > 1

    link = links[0]
    return false if link.nil?

    image_format = link&.image_format
    return false if image_format.nil?

    scale = link.scale
    image_format = image_format.downcase
    scale == 1.0 && %w[svg pdf].include?(image_format)
  end

  def description_params
    JSON.parse(description)
  rescue StandardError
    nil
  end

  def initialize(key:, file_key:, node_id:, name:, description:, containing_frame: nil, image_links: nil)
    @key = key
    @file_key = file_key
    @node_id = node_id
    @name = name
    @description = description
    @containing_frame = containing_frame
    @image_links = image_links
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    key = hash['key']
    file_key = hash['file_key']
    node_id = hash['node_id']
    name = hash['name']
    description = hash['description']
    images_array = hash['image_links']
    image_links = images_array&.map { |i| ImageLink.from_hash(i) }
    containing_frame = FrameInfo.from_hash(hash['containing_frame'])

    if !key.nil? && !file_key.nil? && !node_id.nil? && !name.nil?
      return Component.new(
        key: key,
        file_key: file_key,
        node_id: node_id,
        name: name,
        description: description,
        containing_frame: containing_frame,
        image_links: image_links
      )
    end

    nil
  end

  def to_hash
    hash = {}
    hash['key'] = key
    hash['file_key'] = file_key
    hash['node_id'] = node_id
    hash['name'] = name
    hash['description'] = description
    hash['image_links'] = image_links&.map { |i| i.to_hash } unless image_links.nil?
    hash['description_params'] = description_params unless description_params.nil?
    hash['containing_frame'] = containing_frame&.to_hash
    hash
  end
end
