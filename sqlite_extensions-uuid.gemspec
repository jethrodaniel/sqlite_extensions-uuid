# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "sqlite_extensions-uuid"
  spec.version = "0.0.1"
  spec.authors = ["Mark Delk"]
  spec.email = ["jethrodaniel@gmail.com"]

  spec.summary = "Sqlite's uuid extension"
  spec.homepage = "https://github.com/jethrodaniel/sqlite_extensions-uuid"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.files = %w[
    lib/sqlite_extensions/uuid.rb
    lib/sqlite_extensions/uuid/rails.rb
    ext/sqlite_extensions/uuid/sqlite3ext.h
    ext/sqlite_extensions/uuid/sqlite3.h
    ext/sqlite_extensions/uuid/sqlite3rc.h
    ext/sqlite_extensions/uuid/uuid.c
  ]
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/sqlite_extensions/uuid/extconf.rb"]

  spec.add_development_dependency "debug", ">= 1.0.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "sqlite3", "~> 2.1.0"
end
