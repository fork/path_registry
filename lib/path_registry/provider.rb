module PathRegistry
  module Provider

    def self.install_association(base)
      base.has_one :registered_path,
        :as => :provider, :dependent => :destroy
    end
    def self.install_hooks(base)
      base.after_save   { |r| r.save_registered_path }
    end

  end
end
