# frozen_string_literal: true

require_relative 'figma_paint'
require_relative 'figma_type_style'

class FigmaNode
  attr_accessor :id, :name, :type, :style, :fills

  def initialize(id:, name:, type:, style:, fills:)
    @id = id
    @name = name
    @type = type
    @style = style
    @fills = fills
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    id = hash['id']
    name = hash['name']
    type = hash['type']
    style_hash = hash['style']
    style = style_hash.nil? ? nil : FigmaTypeStyle.from_hash(style_hash)
    fills = (hash['fills'] || []).map { |f| FigmaPaint.from_hash(f) }.compact || []

    if !id.nil? && !name.nil? && !type.nil?
      return FigmaNode.new(id: id, name: name, type: type, style: style, fills: fills)
    end

    nil
  end

  def to_hash
    hash = {}
    hash['id'] = id
    hash['name'] = name
    hash['type'] = type
    hash['style'] = style.to_hash unless style.nil?
    hash['fills'] = (fills || []).map(&:to_hash)
    hash
  end
end
