class RemoveSenderFromMessage < ActiveRecord::Migration
  def up
    remove_column :messages, :sender_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
