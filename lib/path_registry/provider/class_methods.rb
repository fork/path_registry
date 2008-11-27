module PathRegistry
  module Provider
    module ClassMethods

      def configure_registry(opts = {}, &block)
        opts[:path] = block if block
        @path_registry = PathRegistry::Config.new self, registry_defaults, opts

        PathRegistry::Provider.install_association self
        PathRegistry::Provider.install_hooks self

        include Provider::InstanceMethods
      end

      def path_registry
        @path_registry ||= superclass.path_registry
      end

      protected
      def registry_defaults
        {
          :label  => proc { |provider| provider.to_s },
          :path   => proc { |provider| "/#{ name.tableize }/show/#{ provider.id }" },
          :scope  => nil
        }
      end

    end
  end
end

