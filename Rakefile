# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = false
  t.warning = false
end

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options += ["--config", File.join(__dir__, ".rubocop.yml")]
end

task default: %i[test rubocop]
