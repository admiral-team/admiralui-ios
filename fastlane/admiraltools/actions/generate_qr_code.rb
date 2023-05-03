# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'

module Fastlane
  module Actions
    class GenerateQrCodeAction < Action
      def self.run(params)
        Actions.verify_gem!('rqrcode')
        require 'rqrcode'
        require 'fileutils'

        link = params[:link]
        file = params[:file]

        dirname = File.dirname(file)
        FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
        
        qrcode = RQRCode::QRCode.new(link)

        qrcode.as_png(
          bit_depth: 1,
          border_modules: 0,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: 'black',
          file: file,
          fill: 'white',
          module_px_size: 8,
          resize_exactly_to: false,
          resize_gte_to: false,
          size: 120
        )
        
        UI.message('Generate qr-code action finished successfully 🎉')
      end

      def self.description
        'JIRA plugin'
      end

      def self.authors
        ['ton252']
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        'JIRA plugin'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :link,
                                       description: 'Link to be generated',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :file,
                                       description: 'Full file name',
                                       optional: false,
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
