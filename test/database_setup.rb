ActiveRecord::Base.establish_connection(
 :adapter => 'sqlite3',
 :database  => ':memory:'
)

if $-v
  ActiveRecord::Base.logger = ActiveSupport::BufferedLogger.new(STDOUT)
  ActiveRecord::Base.colorize_logging = false
end

ActiveRecord::Base.connection.create_table :consumers do |t|
  t.references :registered_path
end

ActiveRecord::Base.connection.create_table :providers do |t|
  t.string :type
  t.string :slug
end

ActiveRecord::Base.connection.create_table :registered_paths do |t|
  t.references :provider, :polymorphic => true, :null => false

  t.string :scope
  t.string :label
  t.string :path
end

ActiveRecord::Base.connection.add_index :registered_paths, :scope
ActiveRecord::Base.connection.add_index :registered_paths, [:provider_type, :provider_id], :unique => true
