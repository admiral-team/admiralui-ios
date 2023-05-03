# frozen_string_literal: true

class DownloadImageParams
  attr_accessor :image_components, :output_folder, :folder_depth, :output_format, :naming_style,
                :xcassets_params, :convert_svg_to_vector, :convert_scales_to_dpi, 
                :include_page_name, :include_frame_name

  def initialize(
    image_components:,
    output_folder:,
    folder_depth:,
    output_format:,
    naming_style:,
    xcassets_params:,
    convert_svg_to_vector:,
    convert_scales_to_dpi:,
    include_page_name:,
    include_frame_name:
  )
    @image_components = image_components
    @output_folder = output_folder
    @folder_depth = folder_depth
    @output_format = output_format
    @naming_style = naming_style
    @xcassets_params = xcassets_params
    @convert_svg_to_vector = convert_svg_to_vector
    @convert_scales_to_dpi = convert_scales_to_dpi
    @include_page_name = include_page_name
    @include_frame_name = include_frame_name
  end
end
