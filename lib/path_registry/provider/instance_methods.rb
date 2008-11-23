module PathRegistry
  module Provider
    module InstanceMethods

      def save_registered_path
        build_registered_path :provider => self unless registered_path
        registered_path.save
      end

    end
  end
end
