class DropAssetsTable < ActiveRecord::Migration
  def up
    drop_table :assets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

