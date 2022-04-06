# -*- encoding: utf-8 -*-
# stub: fastlane-plugin-create_xcframework 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "fastlane-plugin-create_xcframework".freeze
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Boris Bielik".freeze, "Alexey Alter-Pesotskiy".freeze]
  s.date = "2020-11-04"
  s.description = "Fastlane plugin that creates xcframework for given list of destinations.".freeze
  s.email = ["bielik.boris@gmail.com".freeze, "a.alterpesotskiy@mail.ru".freeze]
  s.homepage = "https://github.com/bielikb/fastlane-plugin-create_xcframework".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.9".freeze
  s.summary = "Fastlane plugin that creates xcframework for given list of destinations.".freeze

  s.installed_by_version = "3.0.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<fasterer>.freeze, ["= 0.8.3"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.49.1"])
      s.add_development_dependency(%q<rubocop-require_tools>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<fastlane>.freeze, [">= 2.144.0"])
    else
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<fasterer>.freeze, ["= 0.8.3"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.49.1"])
      s.add_dependency(%q<rubocop-require_tools>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<fastlane>.freeze, [">= 2.144.0"])
    end
  else
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<fasterer>.freeze, ["= 0.8.3"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.49.1"])
    s.add_dependency(%q<rubocop-require_tools>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<fastlane>.freeze, [">= 2.144.0"])
  end
end
