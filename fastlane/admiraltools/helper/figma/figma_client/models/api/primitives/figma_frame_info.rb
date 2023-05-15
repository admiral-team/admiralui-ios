# frozen_string_literal: true

class FigmaFrameInfo
  attr_accessor \
    :node_id,
    :name,
    :background_color,
    :page_id,
    :page_name

  def initialize(node_id:, name:, background_color:, page_id:, page_name:)
    @node_id = node_id
    @name = name
    @background_color = background_color
    @page_id = page_id
    @page_name = page_name
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    node_id = hash['nodeId']
    name = hash['name']
    background_color = hash['backgroundColor']
    page_id = hash['pageId']
    page_name = hash['pageName']
    
    FigmaFrameInfo.new(
      node_id: node_id, 
      name: name, 
      background_color: background_color,
      page_id: page_id,
      page_name: page_name
    )
  end

  def to_hash
    hash = {}
    hash['nodeId'] = node_id
    hash['name'] = name
    hash['backgroundColor'] = background_color
    hash['pageId'] = page_id
    hash['pageName'] = page_name
    hash
  end
end
