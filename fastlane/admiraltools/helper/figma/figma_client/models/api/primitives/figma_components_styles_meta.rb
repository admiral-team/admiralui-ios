# frozen_string_literal: true

require_relative 'figma_style'
require_relative 'figma_component'

class FigmaComponentsStylesMeta
  attr_accessor :styles, :components

  def initialize(styles:, components:)
    @styles = styles
    @components = components
  end

  def self.from_hash(hash)
    styles_hash = hash['styles']
    components_hash = hash['components']

    styles = styles_hash.nil? ? nil : styles_hash.map { |s| FigmaStyle.from_hash(s) }
    components = components_hash.nil? ? nil : components_hash.map { |c| FigmaComponent.from_hash(c) }

    FigmaComponentsStylesMeta.new(styles: styles, components: components)
  end

  def to_hash
    hash = {}
    hash['styles'] = styles.map(&:to_hash) unless styles.nil?
    hash['components'] = components.map(&:to_hash) unless components.nil?
    hash
  end
end
