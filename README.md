# sqlite_extensions-uuid

SQLite's [UUID v4 extension](https://sqlite.org/src/file/ext/misc/uuid.c?t=version-3.46.1), packaged as a gem.

The main use-case is to allow using UUIDs as primary keys with SQLite in [Rails](https://rubyonrails.org/) apps.

## Installation

Add this gem to your application's `Gemfile` by running this:

```
bundle add sqlite_extensions-uuid
```

or by adding this line and running `bundle`:

```ruby
gem "sqlite_extensions-uuid"
```

In your Rails app, you'll need to load the extension in your `config/database.yml` like so:

```yaml
development:
  adapter: sqlite3
  extensions:
    - <%= SqliteExtensions::UUID.to_path %>
  # ...
```

## Usage

SQLite's uuid extension provides the following:

- `uuid()` - generate a version 4 UUID as a string
- `uuid_str(X)` - convert a UUID X into a well-formed UUID string
- `uuid_blob(X)` - convert a UUID X into a 16-byte blob

For more information about the extension itself, see the extension's [source code](https://sqlite.org/src/file/ext/misc/uuid.c?t=version-3.46.1).

### Examples

Use as a primary key in migrations:

```
bin/rails g model User email_address:uniq:index
```
```ruby
class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :string, default: -> { "uuid()" }, limit: 36 do |t|
      t.string :email_address, null: false
      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end
```

Call SQL directly:

```ruby
ActiveRecord::Base.connection.execute("select uuid_str(uuid())")
#=> [{"uuid_str(uuid())"=>"56392d30-a2cf-47b9-895a-f8c1a1677bfc"}]
```

## How it works

This gem compiles SQLite's uuid extension into a shared library using Ruby's native-gem functionality.

It doesn't _actually_ compile a Ruby native extension, it just uses the ruby extension process to compile the SQLite UUID library.

It then exposes a method, `SqliteExtensions::UUID.to_path`, which returns the location of that shared library.

This can be passed to [sqlite3](https://github.com/sparklemotion/sqlite3-ruby) in `Database.new(extensions: [])` or `Database#load_extension`.

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
