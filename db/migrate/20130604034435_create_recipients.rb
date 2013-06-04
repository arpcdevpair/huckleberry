class CreateRecipients < ActiveRecord::Migration
  class Recipient < ActiveRecord::Base
    attr_accessible :message_id, :user_id
  end
    
  def up

    create_table :recipients do |t|
      t.integer :message_id
      t.integer :user_id

      t.timestamps
    end

    Recipient.reset_column_information
    Message.all.each do |message|
      Recipient.create! message_id: message.id, user_id: message.recipient_id
    end

    remove_column :messages, :recipient_id
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
    
    # add_column :messages, :recipient_id, :integer, null: false, default: 0
     # Recipient.all.each do |recipient|
      # message = Message.find(recipient.message_id)
      # message.recipient_id = recipient.user_id
      # message.save!
    # end
    # drop_table :recipients
  end
end
