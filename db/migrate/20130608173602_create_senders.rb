class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.references :message
      t.references :user

      t.timestamps
    end
    add_index :senders, :message_id
    add_index :senders, :user_id
  end
end
