# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "liquid"
gem "jira-ruby"
gem 'telegram-bot-ruby'
gem "rqrcode", '~> 2.0'
gem "cocoapods", '~>1.9.3'
gem "fastlane"
gem "xcov"
plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
