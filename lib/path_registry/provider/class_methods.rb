module PathRegistry
  module Provider
    module ClassMethods

      def configure_registry(opts, &block)
        @path_registry = PathRegistry::Provider::Config.new(self, opts, &block)

        PathRegistry::Provider.install_association self
        PathRegistry::Provider.install_hooks self

        include Provider::InstanceMethods
      end

      def path_registry
        @path_registry ||= superclass.path_registry
      end

    end
  end
end

