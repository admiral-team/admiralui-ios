# frozen_string_literal: true

class FolderGenerator
  attr_accessor :params

  def initialize(params:)
    @params = params
  end

  def start_download(image_sets:); end

  def end_download(image_sets:); end

  def create_image_sets(image_component:); end

  def image_set_start_download(image_set:); end

  def image_set_end_download(image_set:); end

  def image_start_download(image:); end

  def image_end_download(image:); end

  def format_name(image_component:)
    formatter = ImageNameFormatter.new
    page_name = params.include_page_name ? image_component.containing_frame.page_name : nil
    frame_name = params.include_frame_name ? image_component.containing_frame.name : nil

    formatter.separate(
      name: image_component.name,
      page_name: page_name,
      frame_name: frame_name,
      naming_style: params.naming_style,
      folder_depth: params.folder_depth
    )
  end

  def image_path(group_name:, image_link:, single_scale:)
    formatter = ImageNameFormatter.new
    formatter.image_path(
      group_name: group_name,
      image_link: image_link,
      single_scale: single_scale,
      convert_to_dpi: params.convert_scales_to_dpi
    )
  end
end
