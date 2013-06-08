class Sender < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  attr_accessible :message , :user
end
