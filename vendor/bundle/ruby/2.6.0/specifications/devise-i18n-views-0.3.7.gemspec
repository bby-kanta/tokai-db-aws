# -*- encoding: utf-8 -*-
# stub: devise-i18n-views 0.3.7 ruby lib

Gem::Specification.new do |s|
  s.name = "devise-i18n-views".freeze
  s.version = "0.3.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["mcasimir".freeze, "Jason Barnabe".freeze]
  s.date = "2015-11-29"
  s.description = "Translatable views for devise and the translations that go with them".freeze
  s.email = "jason.barnabe@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "http://github.com/mcasimir/devise-i18n-views".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "I18n support for devise views".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<i18n-spec>.freeze, ["~> 0.6"])
      s.add_development_dependency(%q<localeapp>.freeze, ["~> 0.8"])
      s.add_development_dependency(%q<json>.freeze, [">= 1.8.2"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<i18n-spec>.freeze, ["~> 0.6"])
      s.add_dependency(%q<localeapp>.freeze, ["~> 0.8"])
      s.add_dependency(%q<json>.freeze, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<i18n-spec>.freeze, ["~> 0.6"])
    s.add_dependency(%q<localeapp>.freeze, ["~> 0.8"])
    s.add_dependency(%q<json>.freeze, [">= 1.8.2"])
  end
end
