require "simplecov"
SimpleCov.start

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
    migration_class = if ActiveRecord::Migration.respond_to?(:[])
                        ActiveRecord::Migration[ActiveRecord::Migration.current_version]
                      else
                        ActiveRecord::Migration
                      end

    Class.new(migration_class, &block).new
  end
end
