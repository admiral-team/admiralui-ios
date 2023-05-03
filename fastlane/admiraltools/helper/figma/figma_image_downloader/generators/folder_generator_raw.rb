# frozen_string_literal: true

require_relative 'folder_generator'
require_relative '../helpers/scale_formatter'
require_relative '../helpers/image_name_formatter'
require_relative '../models/image_set_ref'

class FolderGeneratorRaw < FolderGenerator
  def create_image_sets(image_component:)
    name_components = format_name(image_component: image_component)
    name = name_components.name
    folder = name_components.folder

    image_links = image_component.image_links
    single_scale = image_component.single_scale?

    image_refs = image_links.map do |i|
      file_name = image_path(group_name: name, image_link: i, single_scale: single_scale)
      item_path = File.join(folder, file_name)
      ImageRef.new(path: item_path, image_link: i)
    end

    ImageSetRef.new(name: name, folder: folder, image_refs: image_refs, single_scale: single_scale)
  end

  def image_end_download(image:)
    return unless params.convert_svg_to_vector

    input_file = File.join(params.output_folder, image.path)
    SvtToVectorConverter.new.convert(input_file: input_file)
  end
end
