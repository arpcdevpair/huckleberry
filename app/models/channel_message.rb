class ChannelMessage < ActiveRecord::Base
  attr_accessible :channel, :message
  belongs_to :channel
  belongs_to :message
 end
