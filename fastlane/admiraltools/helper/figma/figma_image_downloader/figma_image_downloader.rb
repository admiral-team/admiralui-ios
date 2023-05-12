# frozen_string_literal: true

require_relative 'models/models'
require_relative 'generators/generators'
require_relative 'helpers/progress_tasks_logger'

class FigmaImageDownloader
  OUTPUT_FORMAT_RAW = 'raw'
  OUTPUT_FORMAT_RES = 'res'
  OUTPUT_FORMAT_XCASSETS = 'xcassets'
  OUTPUT_FORMAT_XCASSETS_SYMOBLS = 'xcassets-symbols'

  XCASSETS_TEMPLATE_RENDERING_INTENT_ORIGINAL = 'original'
  XCASSETS_TEMPLATE_RENDERING_INTENT_TEMPLATE = 'template'

  def download_images(params:)
    generator = generator(params: params)

    image_set_refs = params.image_components.map { |c| generator.create_image_sets(image_component: c) }
    total_count = image_set_refs.map(&:image_refs).flatten.length

    logger = ProgressTasksLogger.new(total_count: total_count)
    puts("Start downloading #{total_count}")
    generator.start_download(image_sets: image_set_refs)
    image_set_refs.each do |image_set|
      puts("Image set: #{image_set.name}")
      generator.image_set_start_download(image_set: image_set)
      image_set.image_refs.each do |image|
        generator.image_start_download(image: image)
        download_task(task: image, output_folder: params.output_folder)
        logger.increment
        puts("#{logger.progress_string} #{image.path} #{image.image_link.link}")
        generator.image_end_download(image: image)
      end
      generator.image_set_end_download(image_set: image_set)
    end
    puts("\nDownloading complete! #{logger.progress_string}")
    generator.end_download(image_sets: image_set_refs)
  end

  private

  def generator(params:)
    case params.output_format
    when OUTPUT_FORMAT_RAW
      FolderGeneratorRaw.new(params: params)
    when OUTPUT_FORMAT_RES
      FolderGeneratorRes.new(params: params)
    when OUTPUT_FORMAT_XCASSETS
      FolderGeneratorXcassets.new(params: params, symbols: false)
    when OUTPUT_FORMAT_XCASSETS_SYMOBLS
      FolderGeneratorXcassets.new(params: params, symbols: true)
    else
      raise 'Unknown output format'
    end
  end

  def download_task(task:, output_folder:)
    data = open(task.image_link.link)
    path = File.join(output_folder, task.path)
    file = File.open_file(file_name: path, mode: 'w', create_directories: true)
    file.write(data.read)
    file.close
  end
end
