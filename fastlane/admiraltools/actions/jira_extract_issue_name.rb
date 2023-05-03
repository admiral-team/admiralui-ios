# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/jira/jira_client'

module Fastlane
  module Actions
    class JiraExtractIssueNameAction < Action
      def self.run(params)
        text = params[:text]
        prefix = params[:project_prefix]

        matches = JiraClient.jira_extract_name(text: text, prefix: prefix)

        if matches.size.positive?
          result = matches[0]
          UI.message("Extract issue name [#{result}] finished successfully 🎉")
          result
        else
          UI.user_error!("Extract issue [#{text}] with prefix [#{prefix}] finished with errors 💥")
        end
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
          FastlaneCore::ConfigItem.new(key: :text,
                                       description: 'Input text',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :project_prefix,
                                       description: 'Project prefix',
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
