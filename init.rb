require "#{ File.dirname __FILE__ }/lib/path_registry"
require "#{ Rails.root }/config/path_registry.rb"

ActiveRecord::Base.extend PathRegistry
