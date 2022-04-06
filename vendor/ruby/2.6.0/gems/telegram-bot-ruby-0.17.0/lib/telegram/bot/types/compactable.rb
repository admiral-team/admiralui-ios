module Telegram
  module Bot
    module Types
      module Compactable
        def to_compact_hash
          Hash[attributes.dup.delete_if { |_, v| v.nil? }.map do |key, value|
            value =
              if value.respond_to?(:to_compact_hash)
                value.to_compact_hash
              else
                value
              end

            [key, value]
          end]
        end

        def to_json(*args)
          to_compact_hash.select { |_, v| v }.to_json(*args)
        end
      end
    end
  end
end
