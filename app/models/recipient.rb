class Recipient < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  attr_accessible :message_id, :user_id
end
