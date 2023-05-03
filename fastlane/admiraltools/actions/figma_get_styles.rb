# frozen_string_literal: true

require 'json'
require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/figma/figma_client/figma_client'

module Fastlane
  module Actions
    class FigmaGetStylesAction < Action
      def self.run(params)
        Actions.verify_gem!('liquid')

        access_token = params[:access_token]
        file_key = params[:file_key]
        styles_output_file = params[:output_file]
        style_types = params[:style_types]
        request_batch = params[:request_batch]

        client = FigmaClient.new(access_token: access_token)
        styles = client.get_full_styles(file_key: file_key, request_batch: request_batch) || []
        styles = styles.select { |s| (style_types.nil? || style_types.include?(s.style_type)) }
        styles_list = StylesList.new(styles: styles)

        unless styles_output_file.nil?
          File.write_file_json(
            hash: styles_list.to_hash,
            path: styles_output_file,
            create_directories: true
          )
        end

        styles_list
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
          FastlaneCore::ConfigItem.new(key: :style_types,
                                       description: 'Figma style type filter [FILL, TEXT, EFFECT, GRID]',
                                       optional: true,
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :request_batch,
                                       description: 'Figma max request components batch',
                                       default_value: 1_000_000,
                                       optional: true,
                                       type: Integer),
          FastlaneCore::ConfigItem.new(key: :output_file,
                                       description: 'Figma output styles file path',
                                       optional: true,
                                       type: String)

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
