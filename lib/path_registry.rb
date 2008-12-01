require "#{ File.dirname __FILE__ }/registered_path"

require __FILE__.insert(-4, '/config')
require __FILE__.insert(-4, '/handle_collector')

require __FILE__.insert(-4, '/provider')
require __FILE__.insert(-4, '/provider/instance_methods')
require __FILE__.insert(-4, '/provider/class_methods')

require __FILE__.insert(-4, '/user')
require __FILE__.insert(-4, '/user/class_methods')
require __FILE__.insert(-4, '/user/instance_methods')

module PathRegistry

  @@routings = {}
  def self.notifies(name, &routing)
    @@routings[name] ||= begin
      collector = PathRegistry::HandleCollector.new
      routing[collector]
      collector.to_hash
    end
  end

  def self.registered_path(&block)
    RegisteredPath.module_eval(&block)
  end

  def self.notify(route_name, path)
    for name, routing in @@routings
      route = routing[route_name] and
      path.instance_eval(&route)
    end
  end

  def self.users
    @@users ||= @@routings.keys.inject([]) { |mem, name|
      user = name.constantize rescue nil
      user.respond_to?(:path_registry) ? mem << user : mem
    }
  end

  # Defaults:
  #   :scope      => nil
  #   :label      => proc { |r| r.to_s }
  #   :path       => proc { |r| "#{ r.class.name.tableize }/show/#{ r.id }" }
  def registers_path(opts = {}, &block)
    extend PathRegistry::Provider::ClassMethods
    configure_registry(opts, &block)
  end

  # Defaults:
  #   :scope        => nil
  #   :foreign_key  => :registered_path_id
  def uses_registered_path(opts = {})
    extend PathRegistry::User::ClassMethods
    configure_registry opts
  end

end
