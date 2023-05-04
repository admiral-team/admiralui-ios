# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/figma/figma_client/figma_client'

module Fastlane
  module Actions
    class FigmaGetImageLinksAction < Action
      def self.run(params)
        access_token = params[:access_token]
        file_key = params[:file_key]
        name_filter_regex = params[:name_filter_regex]
        description_filter_regex = params[:description_filter_regex]
        frame_filter_regex = params[:frame_filter_regex]
        page_filter_regex = params[:page_filter_regex]
        components_output_file = params[:output_file]
        image_format = params[:format]
        image_scales = params[:scales]
        svg_include_id = params[:svg_include_id]
        svg_simplify_stroke = params[:svg_simplify_stroke]
        use_absolute_bounds = params[:use_absolute_bounds]
        request_batch = params[:request_batch]
        scales = ScaleFormatter.new.any_scales_to_scales(image_scales)

        client = FigmaClient.new(access_token: access_token)

        components_list = client.get_full_image_components(
          file_key: file_key,
          image_format: image_format,
          scales: scales,
          name_filter_regex: name_filter_regex,
          desc_filter_regex: description_filter_regex,
          frame_filter_regex: frame_filter_regex,
          page_filter_regex: page_filter_regex,
          svg_include_id: svg_include_id,
          svg_simplify_stroke: svg_simplify_stroke,
          use_absolute_bounds: use_absolute_bounds,
          request_batch: request_batch
        )

        unless components_output_file.nil?
          File.write_file_json(
            hash: components_list.to_hash,
            path: components_output_file,
            create_directories: true
          )
        end

        components_list
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
          FastlaneCore::ConfigItem.new(key: :access_token,
                                       description: 'Figma access token',
                                       env_name: 'FIGMA_ACCESS_TOKEN',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :file_key,
                                       env_name: 'FIGMA_FILE_KEY',
                                       description: 'Figma file key',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :name_filter_regex,
                                       description: 'Name filter regex',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :description_filter_regex,
                                       description: 'Description filter regex',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :frame_filter_regex,
                                       description: 'Frame filter regex',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :page_filter_regex,
                                       description: 'Page filter regex',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :format,
                                       description: 'Image output format, can be [jpg png svg pdf]',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :scales,
                                       description: 'An array of number between 0.01 and 4, the image scaling factor. Example: ["0.5", "1", "2", "3"]',
                                       optional: true,
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :request_batch,
                                       description: 'Figma max request components batch',
                                       default_value: 1_000_000,
                                       optional: true,
                                       type: Integer),
          FastlaneCore::ConfigItem.new(key: :output_file,
                                       description: 'Figma output component file path',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :svg_include_id,
                                       description: 'Whether to include id attributes for all SVG elements. Default: false',
                                       optional: true,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :svg_simplify_stroke,
                                       description: 'Whether to simplify inside/outside strokes and use stroke attribute if possible instead of <mask>. Default: true',
                                       optional: true,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :use_absolute_bounds,
                                       description: 'If image use its bounds box',
                                       default_value: true,
                                       optional: true,
                                       type: Boolean)
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
