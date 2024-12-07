# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "sqlite_extensions/uuid"

# NOTE: loading `sqlite3` isn't required by our gem, but we need it for tests.
require "sqlite3"

require "minitest/autorun"
