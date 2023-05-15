# frozen_string_literal: true

#require 'fastlane/plugin/admiraltools/version'
#
module Fastlane
  module Admiraltools
    # Return all .rb files inside the "actions" and "helpers" directory
    def self.all_classes
      Dir[File.expand_path('**/{actions,helpers}/*.rb', File.dirname(__FILE__))]
    end
  end
end

# By default we want to import all available actions and helpers
# A plugin can contain any number of actions and plugins
Fastlane::Admiraltools.all_classes.each do |current|
  require current
end
