module PathRegistry
  class RouteFilter

    def self.define_route_with_name(name)
      define_method(name) {}
    end

    def initialize(name)
      activate_route name
    end

    def find(routing)
      @route = nil; routing[self]
      @route
    end
    alias_method :[], :find

    protected
    def activate_route(name)
      (class << self; self; end).module_eval <<-DEF
      def #{ name }(&block) @route = block end
      DEF
    end

  end
end
