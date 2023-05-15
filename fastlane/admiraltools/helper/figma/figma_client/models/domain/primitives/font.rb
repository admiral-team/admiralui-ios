# frozen_string_literal: true

class Font
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

    font_family = hash['font_family']
    font_postscript_name = hash['font_postscript_name']
    font_size = hash['font_size']
    font_weight = hash['font_weight']
    letter_spacing = hash['letter_spacing']

    if !font_family.nil? && !font_postscript_name.nil? && !font_size.nil? && !font_weight.nil? && !letter_spacing.nil?
      return Font.new(
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
    hash['font_family'] = font_family
    hash['font_postscript_name'] = font_postscript_name
    hash['font_size'] = font_size
    hash['font_weight'] = font_weight
    hash['letter_spacing'] = letter_spacing
    hash
  end
end
