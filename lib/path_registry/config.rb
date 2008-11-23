module PathRegistry
  class Config

    def initialize(owner, defaults, opts)
      @owner = owner
      @opts = sanitize_options opts, defaults

      for name, value in @opts
        case value
        when Proc;      def_method name, value
        when Symbol;    def_accessor name, value
        when NilClass;  def_dongle name
        else
          raise ArgumentError
        end
      end
    end

    def to_hash
      @opts
    end

    protected
    def sanitize_options(opts, defaults, parent = @owner.superclass)
      unless parent.respond_to? :path_registry then defaults.merge opts
      else
        parent.path_registry.to_hash.merge opts
      end
    end
    def meta_class
      (class << self; self; end)
    end

    def def_dongle(name)
      meta_class.module_eval { define_method(name) {|*args|} }
    end
    def def_accessor(accessor_sym, value)
      instance_variable_set :"@#{ accessor_sym }", value
      meta_class.module_eval { attr_reader accessor_sym }
    end
    def def_method(meth_sym, block)
      meta_class.module_eval do
        define_method(meth_sym) { |r| block[r] }
      end
    end

  end
end
