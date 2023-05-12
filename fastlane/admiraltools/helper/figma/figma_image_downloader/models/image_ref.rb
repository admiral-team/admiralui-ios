# frozen_string_literal: true

require_relative '../helpers/scale_formatter'

class ImageRef
  attr_accessor :path, :image_link

  def initialize(path:, image_link:)
    @path = path
    @image_link = image_link
  end
end
