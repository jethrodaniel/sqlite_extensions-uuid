# frozen_string_literal: true

require "test_helper"

class TestUUID < Minitest::Test
  # good enough for testing
  UUID_REGEX = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i

  GEM_NAME = "sqlite_extensions-uuid"

  def test_to_path
    when_this_gem_is_loaded require_path: "foo" do
      path = SqliteExtensions::UUID.to_path
      assert_kind_of String, path

      assert path.end_with?("sqlite_extensions/uuid/uuid")
      assert_equal "foo/sqlite_extensions/uuid/uuid", path
    end
  end

  def test_using_load_extension
    when_this_gem_is_loaded do
      db = SQLite3::Database.new ":memory:"
      db.enable_load_extension(true)
      db.load_extension(SqliteExtensions::UUID.to_path)

      result = db.execute("select uuid()")

      assert_kind_of Array, result
      assert_equal 1, result.size
      assert_kind_of Array, result.first
      assert_equal 1, result.first.size

      uuid = result.first.first
      assert_kind_of String, uuid

      assert_match UUID_REGEX, uuid
    end
  end

  def test_passing_extensions_to_new_database
    when_this_gem_is_loaded do
      db = SQLite3::Database.new(
        ":memory:",
        extensions: [SqliteExtensions::UUID.to_path]
      )

      result = db.execute("select uuid()")

      assert_kind_of Array, result
      assert_equal 1, result.size
      assert_kind_of Array, result.first
      assert_equal 1, result.first.size

      uuid = result.first.first
      assert_kind_of String, uuid

      assert_match UUID_REGEX, uuid
    end
  end

  private

  def local_require_path = File.join(__dir__, "../lib")

  def when_this_gem_is_loaded(require_path: local_require_path, &block)
    test_gemspec = Struct.new(:require_path).new(require_path)
    loaded_specs_stub = { GEM_NAME => test_gemspec }
    Gem.stub(:loaded_specs, loaded_specs_stub, &block)
  end
end
