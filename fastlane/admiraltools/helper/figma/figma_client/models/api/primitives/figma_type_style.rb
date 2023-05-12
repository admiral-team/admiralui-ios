# frozen_string_literal: true

class FigmaTypeStyle
  attr_accessor \
    :font_family,
    :font_postscript_name,
    :font_size,
    :font_weight,
    :letter_spacing

  def initialize(
    font_family:,
    font_postscript_name:,
    font_size:,
    font_weight:,
    letter_spacing:
  )
    @font_family = font_family
    @font_postscript_name = font_postscript_name
    @font_size = font_size
    @font_weight = font_weight
    @letter_spacing = letter_spacing
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    font_family = hash['fontFamily']
    font_postscript_name = hash['fontPostScriptName']
    font_size = hash['fontSize']
    font_weight = hash['fontWeight']
    letter_spacing = hash['letterSpacing']

    if !font_family.nil? && !font_size.nil? && !font_weight.nil? && !letter_spacing.nil?
      return FigmaTypeStyle.new(
        font_family: font_family,
        font_postscript_name: font_postscript_name,
        font_size: font_size,
        font_weight: font_weight,
        letter_spacing: letter_spacing
      )
    end

    nil
  end

  def to_hash
    hash = {}
    hash['fontFamily'] = font_family
    hash['fontPostscriptName'] = font_postscript_name
    hash['fontSize'] = font_size
    hash['fontWeight'] = font_weight
    hash['letterSpacing'] = letter_spacing
    hash
  end
end
