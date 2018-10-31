# -*- encoding: utf-8 -*-
# stub: capistrano-upload-config 0.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-upload-config".freeze
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Robert Coleman".freeze]
  s.date = "2015-12-17"
  s.description = "Capistrano 3.x tasks to upload shared config that is stored outside of SCM".freeze
  s.email = "github@robert.net.nz".freeze
  s.homepage = "https://github.com/rjocoleman/capistrano-upload-config".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Capistrano 3.x tasks to upload shared config that is stored outside of SCM".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<capistrano>.freeze, [">= 3.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>.freeze, [">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
