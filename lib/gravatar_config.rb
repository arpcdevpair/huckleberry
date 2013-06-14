#lim/gravatar_config.rb
module GravatarConfig
  def self.config
    @@config ||={}
  end
  def self.config=(hash)
    @@config = hash
  end
end
