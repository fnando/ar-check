module AR
  module Check
    module CommandRecorder
      # Usage:
      #
      #   add_check :users, :check_user_age, "age > 18"
      #
      def add_check(table, constraint_name, expression)
        record(__method__, [table, constraint_name, expression])
      end

      # Usage:
      #
      #   remove_check :users, :check_user_age
      #
      def remove_check(table, constraint_name)
        record(__method__, [table, constraint_name])
      end

      def invert_add_check(args)
        table, constraint_name, _ = args
        [:remove_check, [table, constraint_name]]
      end
    end
  end
end
