# frozen_string_literal: true

require "active_support/all"
require "active_record"
require "active_record/connection_adapters/postgresql_adapter"
require "active_record/migration/command_recorder"
require "active_record/schema_dumper"
require "ar/check/version"

module AR
  module Check
    require "ar/check/command_recorder"
    require "ar/check/adapter"
    require "ar/check/schema_dumper"
  end
end

ActiveRecord::Migration::CommandRecorder.include AR::Check::CommandRecorder
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.include AR::Check::Adapter
ActiveRecord::SchemaDumper.prepend AR::Check::SchemaDumper
