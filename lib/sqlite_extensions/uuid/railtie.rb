# frozen_string_literal: true

require "sqlite_extensions/uuid"

module SqliteExtensions
  module UUID
    class Railtie < Rails::Railtie
      initializer "sqlite_extensions-uuid.patch_database_adapter" do
        ActiveSupport.on_load(:active_record_sqlite3adapter) do
          prepend DatabaseAdapterExtension
        end
      end

      module DatabaseAdapterExtension
        # https://github.com/rails/rails/blob/v8.0.0.rc1/activerecord/lib/active_record/connection_adapters/sqlite3_adapter.rb#L815
        def configure_connection
          super

          begin
            @raw_connection.enable_load_extension(true)
            @raw_connection.load_extension(SqliteExtensions::UUID.to_path)
          rescue SQLite3::Exception => e
            Rails.logger.error { "Error loading sqlite extension '#{SqliteExtensions::UUID.to_path}' (#{e})" }
          ensure
            @raw_connection.enable_load_extension(false)
          end
        end
      end

      private_constant :DatabaseAdapterExtension
    end
  end
end
