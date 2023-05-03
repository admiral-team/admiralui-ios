# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/jira/jira_client'

module Fastlane
  module Actions
    class JiraGetIssuesAction < Action
      def self.run(params)
        Actions.verify_gem!('jira-ruby')
        require 'jira-ruby'

        username = params[:username]
        user_password = params[:user_password]
        site = params[:site]
        ssl_verify_mode = params[:ssl_verify_mode]
        issue_fields = params[:issue_fields]

        options = {
          username: username,
          password: user_password,
          site: site,
          context_path: '',
          auth_type: :basic,
          ssl_verify_mode: ssl_verify_mode
        }

        jql = params[:jql]
        project = params[:project]
        issue = params[:issue]
        summary = params[:summary]
        fix_version = params[:fix_version]
        resolution = params[:resolution]
        status = params[:status]
        assignee = params[:assignee]
        labels = params[:labels] || []

        jira_params = {
          project: project,
          issue: issue,
          summary: summary,
          fix_version: fix_version,
          resolution: resolution,
          status: status,
          assignee: assignee,
          labels: labels
        }

        jira_client = JiraClient.new(options: options)
        issues = jira_client.get_issues(params: jql || jira_params, fields: issue_fields)

        issues.each { |i| puts(i&.summary) unless i&.summary.nil? }

        issues
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
                                       default_value: OpenSSL::SSL::VERIFY_NONE,
                                       type: Integer),
          FastlaneCore::ConfigItem.new(key: :issue_fields,
                                       description: 'JIRA JQL request',
                                       optional: true,
                                       default_value: %i[
                                         project
                                         key
                                         summary
                                         description
                                         fixVersion
                                         status
                                         resolution
                                         assignee
                                         labels
                                       ],
                                       type: Hash),
          FastlaneCore::ConfigItem.new(key: :jql,
                                       description: 'JIRA JQL request',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :project,
                                       env_name: 'JIRA_PROJECT_NAME',
                                       description: 'JIRA project name',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :issue,
                                       description: 'JIRA issue name/id',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :summary,
                                       description: 'JIRA issue summary (name)',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :fix_version,
                                       description: 'JIRA issue fix version',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :resolution,
                                       description: 'JIRA issue resolution',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :status,
                                       description: 'JIRA issue status',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :labels,
                                       description: 'JIRA issue labels',
                                       optional: true,
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :assignee,
                                       description: 'JIRA issue assignee',
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