# frozen_string_literal: true

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random
  Kernel.srand config.seed
end

require "sqlite_extensions-uuid"
require "debug"

# good enough for testing
UUID_REGEX = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i
