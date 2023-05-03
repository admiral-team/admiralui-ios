# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/jira/jira_client'

module Fastlane
  module Actions
    class JiraReplaceVersionAction < Action
      def self.run(params)
        Actions.verify_gem!('jira-ruby')
        require 'jira-ruby'

        options = {
          username: params[:username],
          password: params[:user_password],
          site: params[:site],
          context_path: '',
          auth_type: :basic,
          ssl_verify_mode: params[:ssl_verify_mode] || OpenSSL::SSL::VERIFY_NONE
        }

        jira_client = JiraClient.new(options: options)

        jira_client.replace_version(
          project: params[:project], 
          name: params[:version_name], 
          version_attrs: params[:version_attrs]
        )
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
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: 'JIRA_USERNAME',
                                       description: 'JIRA user name',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :user_password,
                                       env_name: 'JIRA_USER_PASSWORD',
                                       description: 'JIRA user password',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :site,
                                       env_name: 'JIRA_SITE',
                                       description: 'JIRA site',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :ssl_verify_mode,
                                       env_name: 'JIRA_SSL_VERIFY_MODE',
                                       description: 'JIRA SSL verify mode',
                                       optional: true,
                                       type: Integer),
          FastlaneCore::ConfigItem.new(key: :project,
                                       env_name: 'JIRA_PROJECT_NAME',
                                       description: 'JIRA project name',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :version_name,
                                       description: 'JIRA version name',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :version_attrs,
                                       description: "JIRA version attributes {
                                        \"description\" => \"Description\",
                                        \"name\" => \"Name\",
                                        \"archived\" => false,
                                        \"released\" => false,
                                        \"startDate\" => \"2019-07-22\",
                                        \"releaseDate\" => \"2019-08-18\",
                                        }",
                                       optional: false,
                                       type: Hash),
          FastlaneCore::ConfigItem.new(key: :attachment,
                                       description: 'JIRA issue attachment',
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
