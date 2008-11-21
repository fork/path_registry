require "#{ File.dirname __FILE__ }/registered_path"
require __FILE__.insert(-4, '/event_router')
require __FILE__.insert(-4, '/observer')

require __FILE__.insert(-4, '/consumer')
require __FILE__.insert(-4, '/consumer/class_methods')
require __FILE__.insert(-4, '/consumer/instance_methods')
require __FILE__.insert(-4, '/consumer/config')

require __FILE__.insert(-4, '/provider')
require __FILE__.insert(-4, '/provider/instance_methods')
require __FILE__.insert(-4, '/provider/class_methods')
require __FILE__.insert(-4, '/provider/config')

module PathRegistry

  @@observers = Set.new
  def self.add_observer(name, &routing)
    @@observers << Observer.new(name, routing)
  end
  def self.observers
    @@observers.to_a
  end

  def self.add_event(event_name)
    EventRouter.define_event_with_name event_name
  end

  add_event :update
  add_event :destroy

  def self.registered_path(&block)
    RegisteredPath.instance_eval(&block)
  end

  def self.notify(event_name, path)
    router = EventRouter.new event_name, path
    @@observers.each { |observer| observer.update router }
  end

  # Defaults:
  #   :scope      => nil
  #   :label      => proc { |r| r.to_s }
  #   :path       => proc { |r| "#{ r.class.name.tableize }/show/#{ r.id }" }
  def registers_path(opts = {}, &block)
    extend Provider::ClassMethods
    configure_registry(opts, &block)
  end

  # Defaults:
  #   :scope        => nil
  #   :foreign_key  => :registered_path_id
  def uses_registered_path(opts = {})
    extend Consumer::ClassMethods
    configure_registry opts
  end

end
