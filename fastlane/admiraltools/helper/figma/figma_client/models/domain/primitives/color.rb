# frozen_string_literal: true

class Color
  attr_accessor :r, :g, :b, :a

  def hex
    format('#%02x%02x%02x', *[r, g, b].map { |v| v.to_f * 255 }).upcase
  end

  def hex_with_alpha
    format('#%02x%02x%02x%02x', *[a, r, g, b].map { |v| v.to_f * 255 }).upcase
  end

  def initialize(r:, g:, b:, a:)
    @r = r
    @g = g
    @b = b
    @a = a
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    r = hash['r']
    g = hash['g']
    b = hash['b']
    a = hash['a']

    return Color.new(r: r, g: g, b: b, a: a) if !r.nil? && !g.nil? && !b.nil? && !a.nil?

    nil
  end

  def to_hash
    hash = {}
    hash['r'] = r
    hash['g'] = g
    hash['b'] = b
    hash['a'] = a
    hash['hex'] = hex
    hash['hex_with_alpha'] = hex_with_alpha
    hash
  end
end
