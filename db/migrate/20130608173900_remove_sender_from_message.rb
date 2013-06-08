class RemoveSenderFromMessage < ActiveRecord::Migration
  def up
    remove_column :messages, :sender
  end

  def down
    raise ActiveRecord::IrreversibleMigration
    add_column :message, :sender, :references
  end
end
