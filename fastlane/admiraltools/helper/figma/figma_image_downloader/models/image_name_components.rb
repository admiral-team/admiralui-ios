# frozen_string_literal: true

class ImageNameComponents
  attr_accessor :name, :folder

  def initialize(name:, folder:)
    @name = name
    @folder = folder
  end
end
