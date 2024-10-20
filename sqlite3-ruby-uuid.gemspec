# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "sqlite3-ruby-uuid"
  spec.version = '0.0.1'
  spec.authors = ["Mark Delk"]
  spec.email = ["jethrodaniel@gmail.com"]

  spec.summary = "Sqlite's uuid extension"
  spec.homepage = "https://github.com/jethrodaniel/sqlite3-ruby-uuid"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.files = %w[lib/sqlite3_uuid.rb]
  # spec.bindir = "exe"
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/sqlite3_uuid/extconf.rb"]
end
