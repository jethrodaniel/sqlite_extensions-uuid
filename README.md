# sqlite_extensions-uuid

Sqlite's uuid extension, packaged as a gem.

Useful for using UUIDs as primary keys in a Rails app.

## Installation

Add this to your gemfile:

```ruby
gem "sqlite_extensions-uuid",
  git: "https://github.com/jethrodaniel/sqlite_extensions-uuid",
  require: "sqlite_extensions/uuid/rails"
```

If you're _not_ using Rails, you can omit the `require` above.

## Usage

The extension provides the following:

- `uuid()` - generate a version 4 UUID as a string
- `uuid_str(X)` - convert a UUID X into a well-formed UUID string
- `uuid_blob(X)` - convert a UUID X into a 16-byte blob

In a rails app:

```
bin/rails runner 'puts ActiveRecord::Base.connection.execute("select uuid_str(uuid())")'
{"uuid_str(uuid()) /*application='MyApp'*/"=>"026fbfdf-fa1b-44ec-ab08-eaa9128866a4"}
```

For more information, see the extension's source code ([uuid.c](https://sqlite.org/src/file/ext/misc/uuid.c?t=version-3.46.1)).

## Design

This gem compiles Sqlite's uuid extension into a shared library using Ruby's native-gem functionality.

It doesn't actually compile a Ruby native extension, it just uses the ruby extension process to compile the Sqlite library.

It then exposes a method (`SqliteExtensions::UUID.extension_path`) which returns the location of that shared library, which can be passed to [sqlite3](https://github.com/sparklemotion/sqlite3-ruby)'s `load_extension` method.

Additionally, it exposes a railtie (via `require: "sqlite_extensions/uuid/rails"`) that patches Rails' [configure_connection](https://github.com/rails/rails/blob/v8.0.0.rc1/activerecord/lib/active_record/connection_adapters/sqlite3_adapter.rb#L815) method for the sqlite adapter, so that all sqlite database connections load the extension.

## Development

To install locally

```
# build and run tests
bundle exec rake test

# install locally
bundle exec rake install
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jethrodaniel/sqlite_extensions-uuid.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

The following files are copied verbatim from Sqlite, and are used under their own license, which is visible at the beginning of each file:

- `ext/sqlite_extensions/uuid/sqlite3ext.h`
- `ext/sqlite_extensions/uuid/sqlite3.h`
- `ext/sqlite_extensions/uuid/sqlite3rc.h`
- `ext/sqlite_extensions/uuid/uuid.c`
