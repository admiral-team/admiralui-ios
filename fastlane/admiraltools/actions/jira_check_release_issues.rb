require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/jira/jira_client'

module Fastlane
  module Actions
    class CheckReleaseIssuesAction < Action
      def self.run(params)
        Actions.verify_gem!('jira-ruby')
        require 'jira-ruby'

        username = params[:username]
        user_password = params[:user_password]
        site = params[:site]
        ssl_verify_mode = params[:ssl_verify_mode]

        project = params[:project]
        fix_version = params[:fix_version]
        close_status = params[:close_status]

        options = {
          username: username,
          password: user_password,
          site: site,
          context_path: '',
          auth_type: :basic,
          ssl_verify_mode: ssl_verify_mode
        }

        jira_client = JiraClient.new(options: options)

        jql_params = {
          project: project,
          fix_version: fix_version
        }

        issues = jira_client.separate_release_issues(
          jql_params: jql_params,
          close_status: close_status
        )

        is_all_issues_closed = true

        if issues[:opened].count.positive?
          is_all_issues_closed = false
          issues[:opened].each do |i|
            UI.error("Issue #{i.key} not closed!!!")
          end
        end

        if is_all_issues_closed
          UI.message('Success. All issues closed. 🎉')
        else
          UI.user_error!('Not all issue closed. 💥')
        end

        is_all_issues_closed
      end

      def self.description
        'Check release issues action'
      end

      def self.authors
        ['ton252']
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        'Nexus upload action'
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
          FastlaneCore::ConfigItem.new(key: :fix_version,
                                       description: 'JIRA issue fix version',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :project,
                                       env_name: 'JIRA_PROJECT_NAME',
                                       description: 'JIRA project name',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :close_status,
                                       description: 'JIRA success status',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :ssl_verify_mode,
                                       env_name: 'JIRA_SSL_VERIFY_MODE',
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
