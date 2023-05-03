# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/teamcity/teamcity_client'


module Fastlane
  module Actions
    class TeamcityTriggerAction < Action
      def self.run(params)
        url = params[:url]
        username = params[:username]
        user_password = params[:user_password]
        build_id = params[:build_id]
        branch_name = params[:branch_name]
        ssl_verify_mode = params[:ssl_verify_mode]

        client = TeamCityClient.new(base_url: url, ssl_verify_mode: ssl_verify_mode)
        client.trigger(username: username, user_password: user_password, branch_name: branch_name, build_id: build_id)
      end

      def self.description
        'TeamCity trigger action'
      end

      def self.authors
        ['ton252']
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        'TeamCity trigger action'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: 'TEAMCITY_USERNAME',
                                       description: 'Teamcity user name',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :user_password,
                                       env_name: 'TEAMCITY_PASSWORD',
                                       description: 'Teamcity user password',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :url,
                                       env_name: 'TEAMCITY_URL',
                                       description: 'TeamCity url',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :build_id,
                                       description: 'Teamcity build id',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :branch_name,
                                       description: 'Teamcity branch name',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :ssl_verify_mode,
                                       env_name: 'TEAMCITY_SSL_VERIFY_MODE',
                                       description: 'JIRA SSL verify mode',
                                       optional: true,
                                       default_value: OpenSSL::SSL::VERIFY_NONE,
                                       type: Integer)
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