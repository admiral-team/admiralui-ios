# frozen_string_literal: true

require 'fastlane/action'
require_relative '../helper/admiraltools_helper'

module Fastlane
  module Actions
    class TelegramSendMessageAction < Action
      def self.run(params)
        Actions.verify_gem!('telegram-bot-ruby')
        require 'telegram/bot'

        api_token = params[:api_token]
        chat_ids = params[:chat_ids]
        text = params[:text]
        url_buttons = params[:url_buttons]
        parse_mode = params[:parse_mode]

        Telegram::Bot::Client.run(api_token) do |bot|
          keyboard_buttons = url_buttons&.map do |key, value|
            Telegram::Bot::Types::InlineKeyboardButton.new(text: key, url: value)
          end
          markup = keyboard_buttons.nil? ? nil : Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard_buttons)

          chat_ids.each do |chat_id|
            bot.api.send_message(chat_id: chat_id, text: text, parse_mode: parse_mode, reply_markup: markup)
          end
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
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: 'TELEGRAM_BOT_API_TOKEN',
                                       description: 'Telegram bot api token',
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :chat_ids,
                                       description: 'Telegram chat ids',
                                       optional: false,
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :text,
                                       description: 'Telegram message text',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :parse_mode,
                                       description: 'Message text parse mode',
                                       optional: true,
                                       default_value: 'MarkdownV2',
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :url_buttons,
                                       description: 'Telegram inline keyboards url buttons',
                                       optional: true,
                                       type: Hash)
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
