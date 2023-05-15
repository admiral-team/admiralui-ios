# frozen_string_literal: true

class FigmaColor
  attr_accessor :r, :g, :b, :a

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

    return FigmaColor.new(r: r, g: g, b: b, a: a) if !r.nil? && !g.nil? && !b.nil? && !a.nil?

    nil
  end

  def to_hash
    hash = {}
    hash['r'] = r
    hash['g'] = g
    hash['b'] = b
    hash['a'] = a

    hash
  end
end
