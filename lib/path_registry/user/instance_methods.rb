module PathRegistry
  module User
    module InstanceMethods

      def registered_paths
        if scope = self.class.path_registry.scope(self)
          RegisteredPath.have_scope scope
        else
          RegisteredPath.scopeless
        end
      end

    end
  end
end
