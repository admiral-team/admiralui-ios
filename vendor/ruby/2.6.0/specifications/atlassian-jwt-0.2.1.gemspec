# -*- encoding: utf-8 -*-
# stub: atlassian-jwt 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "atlassian-jwt".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Spike Ilacqua".freeze, "Seb Ruiz".freeze, "Ngoc Dao".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-08-12"
  s.description = "This gem simplifies generating the claims needed to authenticate with the Atlassian Connect REST APIs.".freeze
  s.email = ["spike@6kites.com".freeze, "seb@sebruiz.net".freeze, "ndao@atlassian.com".freeze]
  s.homepage = "https://bitbucket.org/atlassian/atlassian-jwt-ruby".freeze
  s.licenses = ["Apache 2.0".freeze]
  s.rubygems_version = "3.0.9".freeze
  s.summary = "Encode and decode JWT tokens for use with the Atlassian Connect REST APIs.".freeze

  s.installed_by_version = "3.0.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jwt>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<json>.freeze, ["~> 2.2"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
    else
      s.add_dependency(%q<jwt>.freeze, ["~> 2.1"])
      s.add_dependency(%q<json>.freeze, ["~> 2.2"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    end
  else
    s.add_dependency(%q<jwt>.freeze, ["~> 2.1"])
    s.add_dependency(%q<json>.freeze, ["~> 2.2"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
  end
end
