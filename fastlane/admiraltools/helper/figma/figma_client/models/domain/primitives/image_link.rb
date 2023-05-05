# frozen_string_literal: true

class ImageLink
  attr_accessor :link, :scale, :image_format

  def initialize(link:, scale:, image_format:)
    @link = link
    @scale = scale
    @image_format = image_format
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    scale = hash['scale']
    link = hash['link']
    image_format = hash['image_format']

    if !scale.nil? && !link.nil? && !image_format.nil?
      return ImageLink.new(scale: scale, link: link, image_format: image_format)
    end

    nil
  end

  def to_hash
    hash = {}
    hash['scale'] = scale
    hash['link'] = link
    hash['image_format'] = image_format
    hash
  end
end
