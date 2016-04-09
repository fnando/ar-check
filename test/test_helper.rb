require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "bundler/setup"
require "ar/check"
require "minitest/utils"
require "minitest/autorun"

ActiveRecord::Base.establish_connection "postgres:///test"
ActiveRecord::Migration.verbose = false

class Thing < ActiveRecord::Base
end

module TestHelper
  def recreate_table
    ActiveRecord::Schema.define(version: 0) do
      drop_table(:things) rescue nil

      create_table :things do |t|
        t.integer :quantity, default: 0
        t.string :slug
      end
    end
  end

  def with_migration(&block)
    Class.new(ActiveRecord::Migration, &block).new
  end
end
