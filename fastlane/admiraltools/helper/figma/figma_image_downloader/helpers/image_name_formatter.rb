# frozen_string_literal: true

require_relative '../models/image_name_components'
require_relative '../../helpers/string_format'

class ImageNameFormatter
  def separate(name:, naming_style:, folder_depth:, page_name: nil, frame_name: nil)
    name = File.join([page_name, frame_name, name].compact)
    full_name = format_path(name)
    path_components = slice_name(name: full_name, folder_depth: folder_depth)
    name = format_name(name: path_components.name, naming_style: naming_style)
    folder = format_folder(folder: path_components.folder, naming_style: naming_style)
    ImageNameComponents.new(name: name, folder: folder)
  end

  def image_path(group_name:, image_link:, single_scale:, convert_to_dpi: false)
    if single_scale
      "#{group_name}.#{image_link.image_format}"
    else
      scale = ScaleFormatter.new.formatted_scale(scale: image_link.scale, convert_to_dpi: convert_to_dpi)
      "#{group_name}@#{scale}.#{image_link.image_format}"
    end
  end

  private

  def format_name(name:, naming_style:)
    format_string(string: name, naming_style: naming_style).lowercase_first_letter
  end

  def format_folder(folder:, naming_style:)
    folder.split('/').map { |f| format_string(string: f, naming_style: naming_style) }.join('/')
  end

  def format_string(string:, naming_style:)
    string ||= ''
    case naming_style
    when String::FORMAT_STYLE_CAMELCASE
      string.camelcase('-', '_', ' ', '/')
    when String::FORMAT_STYLE_SNAKECASE
      string.snakecase
    when String::FORMAT_STYLE_KEBABCASE
      string.kebabcase
    else
      string
    end
  end

  def slice_name(name:, folder_depth:)
    path_components = (name || '').split('/') || []
    max_index = max(path_components.length - 1, 0)
    folder_depth = folder_depth.negative? ? max_index : folder_depth
    max_depth = max(folder_depth, 0)

    folder = path_components[0, max_depth].join('/') || ''
    name = path_components[max_depth..max_index].join('/') || ''

    ImageNameComponents.new(name: name, folder: folder)
  end

  def format_path(path)
    path.split('/').map(&:strip).join('/')
  end

  def min(a, b)
    [a, b].min
  end

  def max(a, b)
    [a, b].max
  end
end
