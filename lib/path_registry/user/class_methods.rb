module PathRegistry
  module User
    module ClassMethods

      def configure_registry(opts = {})
        @path_registry = PathRegistry::Config.new self, registry_defaults, opts
        PathRegistry::User.install_association self

        include User::InstanceMethods
      end

      def path_registry
        @path_registry ||= superclass.path_registry
      end

      protected
      def registry_defaults
        {
          :foreign_key  => :registered_path_id,
          :scope        => nil
        }
      end

    end
  end
end