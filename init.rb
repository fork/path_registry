require 'path_registry'
require "#{ Rails.root }/config/path_registry.rb"

ActiveRecord::Base.extend PathRegistry
