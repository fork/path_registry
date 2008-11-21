module PathRegistry
  class EventRouter

    def self.define_event_with_name(name)
      define_method(name) {}
    end

    def initialize(event_name, target)
      @target = target
      (class << self; self; end).module_eval <<-DEF
      def #{ event_name }(&block) @target.instance_eval(&block) end
      DEF
    end

    def method_missing(event_name, *args)
      Rails.logger.info "Called unkown event `#{ event_name }' with #{ args.map { |a| a.inspect }.to_sentence }."
    end

    def route(routing, observer)
      instance_eval(&routing)
    end

  end
end
