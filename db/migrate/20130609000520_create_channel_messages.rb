class CreateChannelMessages < ActiveRecord::Migration
  def change
    create_table :channel_messages do |t|
      t.references :channel
      t.references :message

      t.timestamps
    end
    add_index :channel_messages, :channel_id
    add_index :channel_messages, :message_id
  end
end
