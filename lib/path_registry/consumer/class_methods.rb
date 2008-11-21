module PathRegistry
  module Consumer
    module ClassMethods

      def configure_registry(opts)
        @path_registry = PathRegistry::Consumer::Config.new self, opts
        PathRegistry::Consumer.install_association self

        include Consumer::InstanceMethods
      end

      def path_registry
        @path_registry ||= superclass.path_registry
      end

    end
  end
end