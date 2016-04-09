module AR
  module Check
    module Adapter
      def check_constraints(table)
        result = select_all <<-SQL.strip_heredoc
          SELECT c.conname  AS name,
                 c.consrc   AS expression,
                 t1.relname AS table
          FROM pg_constraint c
          JOIN pg_class t1 ON c.conrelid = t1.oid
          JOIN pg_attribute a1 ON a1.attnum = c.conkey[1] AND a1.attrelid = t1.oid
          JOIN pg_namespace t2 ON c.connamespace = t2.oid
          WHERE c.contype = 'c'
            AND c.convalidated = TRUE
            AND t1.relname = '#{table}'
            AND t2.nspname = ANY (current_schemas(false))
        SQL

        result.to_a
      end

      def add_check(table, constraint_name, expression)
        sql = <<-SQL
          ALTER TABLE #{table}
          ADD CONSTRAINT #{quote_column_name("#{constraint_name}_on_#{table}")}
          CHECK (#{expression})
        SQL
        execute(sql)
      end

      def remove_check(table, constraint_name)
        sql = <<-SQL
          ALTER TABLE #{table}
          DROP CONSTRAINT #{quote_column_name("#{constraint_name}_on_#{table}")}
        SQL
        execute(sql)
      end
    end
  end
end
