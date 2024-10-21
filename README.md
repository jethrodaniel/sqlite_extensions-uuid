# sqlite_extensions-uuid

SQLite's [uuid v4 extension](https://sqlite.org/src/file/ext/misc/uuid.c?t=version-3.46.1), packaged as a gem.

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

SQLite's uuid extension provides the following:

- `uuid()` - generate a version 4 UUID as a string
- `uuid_str(X)` - convert a UUID X into a well-formed UUID string
- `uuid_blob(X)` - convert a UUID X into a 16-byte blob

In a rails app:

```ruby
ActiveRecord::Base.connection.execute("select uuid_str(uuid())")
#=> [{"uuid_str(uuid())"=>"56392d30-a2cf-47b9-895a-f8c1a1677bfc"}]
```

For more information, see the extension's [source code](https://sqlite.org/src/file/ext/misc/uuid.c?t=version-3.46.1).

## Design

This gem compiles SQLite's uuid extension into a shared library using Ruby's native-gem functionality.

It doesn't actually compile a Ruby native extension, it just uses the ruby extension process to compile the SQLite library.

It then exposes a method (`SqliteExtensions::UUID.extension_path`) which returns the location of that shared library, which can be passed to [sqlite3](https://github.com/sparklemotion/sqlite3-ruby)'s `load_extension` method.

For Rails, it also exposes a [railtie](https://api.rubyonrails.org/v7.2/classes/Rails/Railtie.html) (via `require: "sqlite_extensions/uuid/rails"`) that patches Rails' [configure_connection](https://github.com/rails/rails/blob/v8.0.0.rc1/activerecord/lib/active_record/connection_adapters/sqlite3_adapter.rb#L815) method for the SQLite adapter, so that all SQLite database connections load the extension.

Ideally, Rails will eventually provide an official way to configure the SQLite connection, at which point we can migrate the railtie to that approach.


## Development

```shell
# one-time setup
bundle

# build and run tests
bundle exec rake test

# install locally
bundle exec rake install

# uninstall
gem uninstall sqlite_extensions-uuid
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jethrodaniel/sqlite_extensions-uuid.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

The following files are copied verbatim from SQLite, and are used under their own license, which is visible at the beginning of each file:

- `ext/sqlite_extensions/uuid/sqlite3ext.h`
- `ext/sqlite_extensions/uuid/sqlite3.h`
- `ext/sqlite_extensions/uuid/uuid.c`
