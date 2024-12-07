# frozen_string_literal: true

module SqliteExtensions
  module UUID
    def self.to_path
      spec = Gem.loaded_specs["sqlite_extensions-uuid"]
      File.join(spec.require_path, "sqlite_extensions/uuid/uuid")
    end
  end
end
