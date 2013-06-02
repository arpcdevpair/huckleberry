class AddSenderToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sender_id, :integer, null: false, default: 0
  end
end
