# frozen_string_literal: true

require_relative 'figma_frame_info'

class FigmaComponent
  attr_accessor \
    :key,
    :file_key,
    :node_id,
    :name,
    :description,
    :containing_frame

  def initialize(key:, file_key:, node_id:, name:, description:, containing_frame:)
    @key = key
    @file_key = file_key
    @node_id = node_id
    @name = name
    @description = description
    @containing_frame = containing_frame
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    key = hash['key']
    file_key = hash['file_key']
    node_id = hash['node_id']
    name = hash['name']
    description = hash['description']
    containing_frame_hash = hash['containing_frame']
    containing_frame = containing_frame_hash.nil? ? nil : FigmaFrameInfo.from_hash(containing_frame_hash)

    if !key.nil? && !file_key.nil? && !node_id.nil? && !name.nil?
      return FigmaComponent.new(
        key: key,
        file_key: file_key,
        node_id: node_id,
        name: name,
        description: description,
        containing_frame: containing_frame
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
    hash['containing_frame'] = containing_frame.to
    hash
  end
end
