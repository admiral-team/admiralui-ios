# frozen_string_literal: true

class FrameInfo
  attr_accessor \
    :node_id,
    :name,
    :background_color,
    :page_id,
    :page_name

  def initialize(
    node_id:,
    name:,
    background_color:,
    page_id:,
    page_name:
  )
    @node_id = node_id
    @name = name
    @background_color = background_color
    @page_id = page_id
    @page_name = page_name
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    node_id = hash['node_id']
    name = hash['name']
    background_color = hash['background_color']
    page_id = hash['page_id']
    page_name = hash['page_name']
    FigmaFrameInfo.new(node_id: node_id, name: name, background_color: background_color, page_id: page_id,
                       page_name: page_name)
  end

  def to_hash
    hash = {}
    hash['node_id'] = node_id
    hash['name'] = name
    hash['background_color'] = background_color
    hash['page_id'] = page_id
    hash['page_name'] = page_name
    hash
  end
end
