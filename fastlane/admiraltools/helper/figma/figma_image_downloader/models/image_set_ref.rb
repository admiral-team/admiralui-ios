# frozen_string_literal: true

require_relative 'image_ref'

class ImageSetRef
  attr_accessor :name, :folder, :image_refs, :single_scale

  def initialize(name:, folder:, image_refs:, single_scale:)
    @name = name || ''
    @folder = folder || ''
    @image_refs = image_refs || []
    @single_scale = single_scale
  end
end
