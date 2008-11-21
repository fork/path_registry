module PathRegistry
  class Observer

    attr_reader :name

    @@instances = {}
    def self.new(name, routing)
      self [ name.to_sym ] ||= begin
        instance = allocate
        instance.instance_eval { initialize name, routing }

        instance
      end
    end

    def user
      yield @name.constantize rescue nil
    end

    def self.[](name)
      @@instances[ name.to_sym ]
    end

    def initialize(name, routing)
      @name, @routing = name, routing
    end

    def update(event_router)
      event_router.route @routing
    end

    protected
    def self.[]=(name, instance)
      @@instances[ name.to_sym ] = instance
    end

  end
end
