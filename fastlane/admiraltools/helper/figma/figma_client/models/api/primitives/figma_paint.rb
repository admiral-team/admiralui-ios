# frozen_string_literal: true

require_relative 'figma_color'

class FigmaPaint
  attr_accessor :type, :color, :opacity

  def initialize(type:, color:, opacity:)
    @type = type
    @color = color
    @opacity = opacity
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    type = hash['type']
    color = FigmaColor.from_hash(hash['color'])
    opacity = hash['opacity'] || 1.0

    return FigmaPaint.new(type: type, color: color, opacity: opacity) if !type.nil? && !color.nil?

    nil
  end

  def to_hash
    hash = {}
    hash['type'] = type
    hash['color'] = color.to_hash unless color.nil?
    hash
  end
end
