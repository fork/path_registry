require 'fileutils'

module Install

  TIME = Time.now
  ROOT = File.dirname __FILE__  
  rails_root = File.join ROOT, %w[ .. .. .. ]
  RAILS_ROOT = File.expand_path rails_root

  def copy(basename, target)
    source = File.join ROOT, 'install', basename
    target = File.join RAILS_ROOT, target

    begin
      FileUtils.cp source, target, :verbose => true
    rescue
      puts "=> failed!"
    end
  end

  def timestamp
    TIME.strftime '%Y%m%d%H%M%S'
  end

  module_function :copy, :timestamp

end

puts 'PathRegistry:'
puts

Install.copy 'config.rb', %w[config path_registry.rb]
Install.copy 'migration.rb', %W[db migrate #{ Install.timestamp }_create_registered_paths.rb]

puts
puts 'Note: Please register event routes in config/path_registry.rb and run migrations.'
