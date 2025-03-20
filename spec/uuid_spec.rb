# frozen_string_literal: true

require "sqlite_extensions/uuid"

RSpec.describe SqliteExtensions::UUID do # rubocop:disable Metrics/BlockLength
  it "has a version" do
    expect(described_class::VERSION).to eq "1.0.1"
  end

  describe "#to_path" do
    before do
      gemspec = instance_double(Gem::Specification, require_path: "foo")
      allow(Gem).to receive(:loaded_specs).and_return("sqlite_extensions-uuid" => gemspec)
    end

    it "returns the path to the compiled extension" do
      path = SqliteExtensions::UUID.to_path

      expect(path).to eq "foo/sqlite_extensions/uuid/uuid"
    end
  end

  it "has the correct gemspec info" do
    path = File.expand_path("../sqlite_extensions-uuid.gemspec", __dir__)
    gemspec = Gem::Specification.load path

    expect(gemspec).to have_attributes(
      name: "sqlite_extensions-uuid",
      version: Gem::Version.new("1.0.1"),
      files: %w[
        ext/sqlite_extensions/uuid/extconf.rb
        ext/sqlite_extensions/uuid/sqlite3.h
        ext/sqlite_extensions/uuid/sqlite3ext.h
        ext/sqlite_extensions/uuid/uuid.c
        lib/sqlite_extensions/uuid.rb
        lib/sqlite_extensions/uuid/version.rb
      ],
      licenses: ["MIT"],
      metadata: {},
      required_ruby_version: Gem::Requirement.new([">= 3.0.0"]),
      summary: "SQLite's UUID v4 extension, packaged as a gem"
    )
    require_paths = gemspec.require_paths
    expect(require_paths.size).to eq 2
    expect(require_paths.first).to end_with "sqlite_extensions-uuid-1.0.1"
    expect(require_paths.last).to eq "lib"
  end
end
