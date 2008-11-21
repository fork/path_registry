require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'action_controller'

require 'expectations'

module Rails

  LOGGER = ActiveSupport::BufferedLogger.new STDOUT
  def logger
    LOGGER
  end
  ROOT = File.dirname __FILE__
  def root
    ROOT
  end

  module_function :logger, :root

end

require "#{ File.dirname __FILE__ }/../init.rb"

Consumer = Class.new ActiveRecord::Base do
  attr_accessor :routed_by_the_first_routing
  uses_registered_path
end

require "#{ File.dirname __FILE__ }/provider"
require "#{ File.dirname __FILE__ }/database_setup"