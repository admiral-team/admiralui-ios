# frozen_string_literal: true

class StylesGroup
  attr_accessor :name, :styles

  def initialize(name:, styles:)
    @name = name
    @styles = styles
  end

  def is_dark
    name.downcase.include?('dark') || false
  end

  def to_hash
    hash = {}
    hash['name'] = name
    hash['styles'] = styles&.map { |s| s.to_hash }
    hash['is_dark'] = is_dark
    hash
  end
end
