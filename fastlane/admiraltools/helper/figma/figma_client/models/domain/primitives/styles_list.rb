# frozen_string_literal: true

require 'json'
require_relative 'style'

class StylesList
  attr_accessor :styles

  def initialize(styles:)
    @styles = styles
  end

  def self.from_hash(hash)
    hash.map { |s| Style.from_hash(s) }
  end

  def to_hash
    styles.map(&:to_hash)
  end

  def self.from_json(json)
    styles = (JSON.parse(json) || []).map { |s| Style.from_hash(s) }
    StylesList.new(styles: styles)
  end

  def to_json(*_args)
    styles.map(&:to_hash).to_json
  end
end
