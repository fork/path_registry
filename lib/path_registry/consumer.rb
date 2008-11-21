module PathRegistry
  module Consumer

    def self.install_association(base)
      base.belongs_to :registered_path,
        :foreign_key => base.path_registry.foreign_key
    end

  end
end
