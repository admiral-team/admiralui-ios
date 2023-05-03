# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'
require_relative '../helper/nexus/nexus_client'

module Fastlane
  module Actions
    class NexusUploadMavenAction < Action
      def self.run(params)
        client = NexusClient.new(
          base_url: params[:url],
          ssl_verify_mode: params[:ssl_verify_mode]
        )

        client.upload_maven(
          username: params[:username],
          password: params[:password],
          repository: params[:repository],
          group_id: params[:group_id],
          artifact_id: params[:artifact_id],
          version: params[:version],
          generate_pom: params[:generate_pom],
          packaging: params[:packaging],
          assets: params[:assets]
        )
      end

      def self.description
        'Nexus upload action'
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
                                       env_name: 'NEXUS_USERNAME',
                                       description: 'Nexus user name',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: 'NEXUS_PASSWORD',
                                       description: 'Nexus user password',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :url,
                                       env_name: 'NEXUS_URL',
                                       description: 'Nexus base url',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :ssl_verify_mode,
                                       env_name: 'NEXUS_SSL_VERIFY_MODE',
                                       description: 'Nexus SSL verify mode',
                                       optional: true,
                                       default_value: OpenSSL::SSL::VERIFY_NONE,
                                       type: Integer),
          FastlaneCore::ConfigItem.new(key: :repository,
                                       description: 'Nexus repository',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :group_id,
                                       description: 'Nexusecomponent group_id',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :artifact_id,
                                       description: 'Nexus component artifact_id',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :version,
                                       description: 'Nexus component version',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :generate_pom,
                                       description: 'Nexus component generate_pom',
                                       optional: true,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :packaging,
                                       description: 'Nexus component packaging',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :assets,
                                       description: 'Array of Nexus binary assets in format [{\'path\': \'file_path\'}, \'extension\': \'file_extension\'}]',
                                       optional: false,
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