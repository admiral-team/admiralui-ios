# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/figma/figma_image_downloader/figma_image_downloader'

module Fastlane
  module Actions
    class FigmaDownloadImagesAction < Action
      def self.run(params)
        image_components_json = params[:image_components]
        output_folder = params[:output_folder]
        output_format = params[:output_format]
        folder_depth = params[:folder_depth]
        naming_style = params[:naming_style]
        xcassets_params = params[:xcassets_params]
        convert_svg_to_vector = params[:convert_svg_to_vector]
        convert_scales_to_dpi = params[:convert_scales_to_dpi]
        include_page_name = params[:include_page_name]
        include_frame_name = params[:include_frame_name]

        image_components = ComponentsList.from_json(image_components_json).components || []
        downloader = FigmaImageDownloader.new

        image_params = DownloadImageParams.new(
          image_components: image_components,
          output_folder: output_folder,
          folder_depth: folder_depth,
          output_format: output_format,
          naming_style: naming_style,
          xcassets_params: xcassets_params,
          convert_svg_to_vector: convert_svg_to_vector,
          convert_scales_to_dpi: convert_scales_to_dpi,
          include_page_name: include_page_name,
          include_frame_name: include_frame_name
        )

        downloader.download_images(params: image_params)
      end

      def self.description
        'Figma plugin'
      end

      def self.authors
        ['ton252']
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        'Figma plugin'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :image_components,
                                       description: 'Image components json',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :output_folder,
                                       description: 'Output folder path',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :output_format,
                                       description: "Output type: #{FigmaImageDownloader::OUTPUT_FORMAT_XCASSETS}, #{FigmaImageDownloader::OUTPUT_FORMAT_RES}, #{FigmaImageDownloader::OUTPUT_FORMAT_RAW}",
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :folder_depth,
                                       description: 'Folder depth',
                                       optional: true,
                                       default_value: -1,
                                       type: Integer),
          FastlaneCore::ConfigItem.new(key: :naming_style,
                                       description: "Image naming style: #{String::FORMAT_STYLE_CAMELCASE}, #{String::FORMAT_STYLE_SNAKECASE}, #{String::FORMAT_STYLE_KEBABCASE}",
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :xcassets_params,
                                       description: 'Xcassets parameters (template_rendering_intent, provides-namespace, preserves_vector_representation)',
                                       optional: true,
                                       type: Hash),
          FastlaneCore::ConfigItem.new(key: :convert_svg_to_vector,
                                       description: 'Convert svg images to Android vector',
                                       optional: true,
                                       default_value: false,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :convert_scales_to_dpi,
                                       description: 'Convert scales to dpi',
                                       optional: true,
                                       default_value: false,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :include_page_name,
                                       description: 'Include page name',
                                       optional: true,
                                       default_value: false,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :include_frame_name,
                                       description: 'Include page name',
                                       optional: true,
                                       default_value: false,
                                       is_string: false)
        ]
      end

      def self.is_supported?(_platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
