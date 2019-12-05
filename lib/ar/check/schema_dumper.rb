# frozen_string_literal: true

module AR
  module Check
    module SchemaDumper
      def table(table_name, stream)
        super
        check_constraints(table_name, stream)
      end

      def check_constraints(table, stream)
        constraints = @connection.check_constraints(table)
        return if constraints.empty?

        constraints.each do |constraint|
          expression = constraint["expression"]
                       .gsub(/^\s*CHECK\s+\(/i, "")
                       .gsub(/\)$/, "")

          statement = [
            "add_check",
            ":#{constraint['table']},",
            ":#{constraint['name'].gsub("_on_#{table}", '')},",
            expression.inspect
          ].join(" ")

          stream.puts "  #{statement}"
        end

        stream.puts
      end
    end
  end
end
