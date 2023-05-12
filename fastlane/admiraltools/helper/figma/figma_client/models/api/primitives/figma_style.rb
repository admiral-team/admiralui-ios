# frozen_string_literal: true

FIGMA_STYLE_TYPE_FILL = 'FILL'
FIGMA_STYLE_TYPE_TEXT = 'TEXT'

class FigmaStyle
  attr_accessor \
    :name,
    :node_id,
    :style_type,
    :description

  def initialize(
    name:,
    node_id:,
    style_type:,
    description:
  )
    @name = name
    @node_id = node_id
    @style_type = style_type
    @description = description
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    name = hash['name']
    node_id = hash['node_id']
    style_type = hash['style_type']
    description = hash['description']

    if !name.nil? && !node_id.nil? && style_type
      return FigmaStyle.new(name: name, node_id: node_id, style_type: style_type, description: description)
    end

    nil
  end

  def to_hash
    hash = {}
    hash['name'] = name
    hash['node_id'] = node_id
    hash['style_type'] = style_type
    hash['description'] = description
    hash
  end
end
