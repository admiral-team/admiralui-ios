module Telegram
  module Bot
    module Types
      class WebhookInfo < Base
        attribute :url, String
        attribute :has_custom_certificate, Boolean
        attribute :pending_update_count, Integer
        attribute :ip_address, String
        attribute :last_error_date, Integer
        attribute :last_error_message, String
        attribute :max_connections, String
        attribute :max_connections, Integer
        attribute :allowed_updates, Array[String]
      end
    end
  end
end
