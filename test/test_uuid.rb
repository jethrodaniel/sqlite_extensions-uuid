# frozen_string_literal: true

require "test_helper"

class TestUUID < Minitest::Test
  def test_extension_path
    loaded_specs_stub = {
      "sqlite_extensions-uuid" => Struct.new(:require_path).new("foo")
    }
    Gem.stub(:loaded_specs, loaded_specs_stub) do
      path = SqliteExtensions::UUID.extension_path
      assert_kind_of String, path

      assert path.end_with?("sqlite_extensions/uuid/uuid")
      assert_equal "foo/sqlite_extensions/uuid/uuid", path
    end
  end

  def test_it_works
    require "sqlite3"

    db = SQLite3::Database.new ":memory:"
    db.enable_load_extension(true)
    extension_path = File.join(__dir__, "../lib/sqlite_extensions/uuid/uuid")
    db.load_extension(extension_path)

    result = db.execute("select uuid()")
    assert_kind_of Array, result
    assert_equal 1, result.size
    assert_kind_of Array, result.first
    assert_equal 1, result.first.size

    uuid = result.first.first
    assert_kind_of String, uuid

    assert_match(
      /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i,
      uuid
    )
  end

  def test_rails_integration
    skip "TODO"
  end
end
