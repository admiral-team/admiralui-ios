# frozen_string_literal: true

require 'json'
require_relative 'component'

class ComponentsList
  attr_accessor :components

  def initialize(components:)
    @components = components
  end

  def self.from_hash(hash)
    hash.map { |s| Component.from_hash(s) }
  end

  def to_hash
    components.map(&:to_hash)
  end

  def self.from_json(json)
    components = (JSON.parse(json) || []).map { |s| Component.from_hash(s) }
    ComponentsList.new(components: components)
  end

  def to_json(*_args)
    components.map(&:to_hash).to_json
  end
end
