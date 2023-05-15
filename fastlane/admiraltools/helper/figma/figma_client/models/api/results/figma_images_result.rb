# frozen_string_literal: true

class FigmaImagesResult
  attr_accessor :error, :images

  def initialize(error:, images:)
    @error = error
    @images = images || []
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    error = hash['err']
    images = hash['images']
    FigmaImagesResult.new(error: error, images: images)
  end

  def to_hash
    hash = {}
    hash['err'] = error
    hash['images'] = images
    hash
  end
end
