# frozen_string_literal: true

module SqliteExtensions
  module UUID
    class << self
      def to_path
        spec = Gem.loaded_specs["sqlite_extensions-uuid"]
        File.join(spec.require_path, "sqlite_extensions/uuid/uuid")
      end

      alias extension_path to_path
    end
  end
end
