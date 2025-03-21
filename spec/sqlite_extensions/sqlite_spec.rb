# frozen_string_literal: true

# not required by our gem, but needed for these tests
require "sqlite3"

RSpec.describe "Sqlite3 usage" do # rubocop:disable RSpec/DescribeClass
  before do
    gemspec = instance_double(
      Gem::Specification,
      require_path: File.join(__dir__, "../../lib")
    )
    allow(Gem).to receive(:loaded_specs).and_return("sqlite_extensions-uuid" => gemspec)
  end

  it "works when passed as an extension to SQLite3::Database.new" do
    db = SQLite3::Database.new(":memory:", extensions: [SqliteExtensions::UUID.to_path])

    result = db.execute("select uuid()")

    expect(result).to match([[an_instance_of(String)]])
    uuid = result.first.first
    expect(uuid).to match(UUID_REGEX)
  end

  it "works when using `enable_load_extension`" do
    db = SQLite3::Database.new ":memory:"
    db.enable_load_extension(true)
    db.load_extension(SqliteExtensions::UUID.to_path)

    result = db.execute("select uuid()")

    expect(result).to match([[an_instance_of(String)]])
    uuid = result.first.first
    expect(uuid).to match(UUID_REGEX)
  end
end
