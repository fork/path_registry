module PathRegistry
  module Consumer
    class Config

      attr_reader :owner, :foreign_key

      DEFAULT_OPTIONS = {
        :foreign_key  => :registered_path_id,
        :scope        => nil
      }

      def initialize(owner, opts)
        @owner = owner
        opts = sanitize_options opts

        @foreign_key  = opts[:foreign_key]
        def_method :scope, opts[:scope] if opts[:scope]
      end

      def scope(record) end

      def to_hash
        {
          :foreign_key  => @foreign_key,
          :scope        => method(:scope).to_proc
        }
      end

      protected
      def sanitize_options(opts)
        parent = @owner.superclass

        unless parent.respond_to? :path_registry
          DEFAULT_OPTIONS.merge opts
        else
          parent.path_registry.to_hash.merge opts
        end
      end
      def def_method(meth_sym, block)
        (class << self; self; end).
        module_eval { define_method(meth_sym, &block) }
      end

    end
  end
end
