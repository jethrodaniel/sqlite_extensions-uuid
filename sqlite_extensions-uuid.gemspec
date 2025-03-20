# frozen_string_literal: true

require_relative "lib/sqlite_extensions/uuid/version"

Gem::Specification.new do |spec|
  spec.name = "sqlite_extensions-uuid"
  spec.version = SqliteExtensions::UUID::VERSION
  spec.authors = ["Mark Delk"]
  spec.email = ["jethrodaniel@gmail.com"]

  spec.summary = "SQLite's UUID v4 extension, packaged as a gem"
  spec.homepage = "https://github.com/jethrodaniel/sqlite_extensions-uuid"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.files = Dir.glob("lib/**/*.rb") + Dir.glob("ext/**/*.{c,h}")
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/sqlite_extensions/uuid/extconf.rb"]

  spec.add_dependency "sqlite3", ">= 2.4.0"

  spec.add_development_dependency "debug", ">= 1.0.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "rubocop-performance"
end
