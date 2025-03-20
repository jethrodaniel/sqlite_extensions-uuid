# frozen_string_literal: true

# not required by our gem, but needed for these tests
require "sqlite3"
require "active_record/railtie"
require "minitest/autorun"

# Adapted from https://github.com/rails/rails/blob/v8.0.2/guides/bug_report_templates/active_record_migrations.rb
#
RSpec.describe "Rails usage" do # rubocop:disable RSpec/DescribeClass
  before do
    gemspec = instance_double(
      Gem::Specification,
      require_path: File.join(__dir__, "../../lib")
    )
    allow(Gem).to receive(:loaded_specs).and_return("sqlite_extensions-uuid" => gemspec)

    ENV["RAILS_ENV"] = "production"

    # config/application.rb
    stub_const("TestApp", Class.new(Rails::Application) do
      config.load_defaults Rails::VERSION::STRING.to_f
      config.eager_load = false
      config.secret_key_base = "secret_key_base"
    end)
    Rails.application.initialize!

    # db/migrate/yyyymmddhhmmss_create_users.rb
    stub_const("CreateUsers", Class.new(ActiveRecord::Migration[8.0]) do
      def change
        create_table :users, id: :string, default: -> { "uuid()" }, limit: 36 do |t|
          t.string :email_address, null: false
          t.timestamps
        end
        add_index :users, :email_address, unique: true
      end
    end)

    # app/models/user.rb
    stub_const("User", Class.new(ActiveRecord::Base))
  end

  it "allows Rails to support UUIDs for SQLite" do
    log_file = StringIO.new

    # TODO: prevent Rails from logging to stdout entirely
    allow(Rails.logger).to receive(:debug).and_wrap_original do |m, msg|
      log_file.write msg
    end

    CreateUsers.migrate(:up)

    log_file.rewind
    output = log_file.read

    expect(output).to include('CREATE TABLE "users"')
    expect(output).to include("varchar(36) DEFAULT (uuid())")

    id_column = User.columns.find { |column| column.name == "id" }
    expect(id_column.sql_type).to eq "varchar(36)"

    user = User.create!(email_address: "a@b.c")
    expect(user.id).to match(UUID_REGEX)
  end
end
