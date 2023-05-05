# frozen_string_literal: true

require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?('UI')

  module Helper
    class AdmiraltoolsHelper
      # class methods that you define here become available in your action
      # as `Helper::AdmiraltoolsHelper.your_method`
      #
      def self.show_message
        UI.message('Hello from the admiraltools plugin helpers!')
      end
    end
  end
end
