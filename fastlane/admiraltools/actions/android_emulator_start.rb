# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/android/android_emulator_manager'

module Fastlane
  module Actions
    class AndroidEmulatorStartAction < Action
      def self.run(params)
        adb_path = params[:adb_path]
        emulator_path = params[:emulator_path]
        emulator_name = params[:emulator_name]

        manager = AndroidEmulatorManager.new(
          adb_path: adb_path,
          emulator_path: emulator_path
        )

        manager.start_emulator_by_name(emulator_name)

        UI.message('Emulator successfully started 🎉')
      end

      def self.description
        'Android studio emulator plugin'
      end

      def self.authors
        ['ton252']
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        'Android studio emulator plugin'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :emulator_path,
                                       env_name: 'ANDROID_EMULATOR_PATH',
                                       description: 'Android Studio system emulator tools path',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :adb_path,
                                       env_name: 'ANDROID_ADB_PATH',
                                       description: 'Android Studio system adb tools path',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :emulator_name,
                                       description: 'Android Studio system adb tools path',
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