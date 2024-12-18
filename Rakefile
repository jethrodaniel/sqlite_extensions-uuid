# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/extensiontask"
require "rake/testtask"
require "rubocop/rake_task"

task build: :compile

GEMSPEC = Gem::Specification.load(Dir.glob("*.gemspec").first)

Rake::ExtensionTask.new("sqlite_extensions/uuid", GEMSPEC) do |ext|
  ext.name = "uuid"
  ext.lib_dir = "lib/sqlite_extensions/uuid"
end

task default: %i[clobber compile]

task :update do
  sh "wget https://sqlite.org/2024/sqlite-autoconf-3460100.tar.gz"
  sh "tar xvf sqlite-autoconf-3460100.tar.gz"
  sh "cp -v ./sqlite-autoconf-3460100/*.h ext/sqlite_extensions/uuid/"
  sh "rm -rf sqlite-autoconf-3460100*"

  sh "wget https://github.com/sqlite/sqlite/raw/refs/tags/version-3.46.1/ext/misc/uuid.c"
  sh "mv -v ./uuid.c ext/sqlite_extensions/uuid/"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/test_*.rb"]
  t.verbose = true
end

task test: :compile

RuboCop::RakeTask.new

task lint: "rubocop:autocorrect_all"
