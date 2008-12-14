class CreateRegisteredPaths < ActiveRecord::Migration
  def self.up
    create_table :registered_paths do |t|
      t.references :provider, :polymorphic => true, :null => false

      t.string :scope
      t.string :label
      t.string :path
    end

    add_index :registered_paths, :scope
    add_index :registered_paths, :path, :unique => true

    add_index :registered_paths, [:provider_type, :provider_id], :unique => true
  end

  def self.down
    drop_table :registered_paths
  end
end
