# frozen_string_literal: true

require 'json'
require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/figma/figma_template_generator/figma_template_generator'

module Fastlane
  module Actions
    class FigmaGenerateStylesAction < Action
      def self.run(params)
        Actions.verify_gem!('liquid')

        styles_json = params[:styles]
        style_types = params[:style_types]
        template_file = params[:template_file]
        output_file = params[:output_file]

        generator = FigmaTemplateGenerator.new
        styles = StylesList.from_json(styles_json).styles

        generator.generate(
          styles: styles,
          style_types: style_types,
          template_path: template_file,
          output_path: output_file
        )
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
          FastlaneCore::ConfigItem.new(key: :styles,
                                       description: 'Figma styles list json',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :template_file,
                                       description: 'Figma template liquid file path',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :output_file,
                                       description: 'Figma output styles file path',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :style_types,
                                       description: 'Figma style type filter [FILL, TEXT, EFFECT, GRID]',
                                       optional: true,
                                       type: Array)

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
