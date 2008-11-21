module PathRegistry
  module Provider
    class Config

      attr_reader :owner

      DEFAULT_OPTIONS = {
        :label  => proc { |r| r.to_s },
        :path   => proc { |r| "/#{ r.class.name.tableize }/show/#{ r.id }" },
        :scope  => nil
      }

      def initialize(owner, opts, &block)
        @owner = owner
        opts = sanitize_options opts

        def_method :label, opts[:label]
        def_method :path, block || opts[:path]
        def_method :scope, opts[:scope] if opts[:scope]
      end

      def label(record) end
      def path(record) end
      def scope(record) end

      def to_hash
        {
          :label  => method(:label).to_proc,
          :path   => method(:path).to_proc,
          :scope  => method(:scope).to_proc
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
