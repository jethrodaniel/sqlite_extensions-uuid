# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/extensiontask"

task build: :compile

GEMSPEC = Gem::Specification.load("sqlite3-ruby-uuid.gemspec")

Rake::ExtensionTask.new("sqlite3_uuid", GEMSPEC) do |ext|
  ext.name = "uuid"
  ext.lib_dir = "lib/sqlite3_uuid"
end

task default: %i[clobber compile]

task :update do
  sh "wget https://sqlite.org/2024/sqlite-autoconf-3460100.tar.gz"
  sh "tar xvf sqlite-autoconf-3460100.tar.gz"
  sh "cp -v ./sqlite-autoconf-3460100/*.h ext/sqlite3_uuid/"
  sh "rm -rf sqlite-autoconf-3460100*"

  sh "wget https://github.com/sqlite/sqlite/raw/refs/tags/version-3.46.1/ext/misc/uuid.c"
  sh "mv -v ./uuid.c ext/sqlite3_uuid/"
end

task test: :default do
  require "sqlite3"

  db = SQLite3::Database.new ":memory:"
  db.enable_load_extension(true)
  # db.load_extension('./lib/sqlite3_uuid/uuid')

  # require 'sqlite3_uuid'
  # ext = File.join(Gem.loaded_specs['sqlite3-ruby-uuid'].extensions_dir, 'sqlite3_uuid', 'uuid')

  ext = File.join(RbConfig::CONFIG['sitearchdir'], 'sqlite3_uuid', 'uuid')
  db.load_extension(ext)

  puts "--- Tests ---"
  puts "'select uuid()' => #{db.execute("select uuid()")}"
end
