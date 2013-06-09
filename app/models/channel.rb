class Channel < ActiveRecord::Base
  attr_accessible :name
  has_many :channelMessages
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  def to_param
    name
  end
end
