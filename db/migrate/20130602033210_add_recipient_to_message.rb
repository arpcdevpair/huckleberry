class AddRecipientToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :recipient_id, :integer, null: false, default: 0
  end
end
