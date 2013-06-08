#lim/fogbugz_config.rb
module FogbugzConfig
  def self.config
    @@config ||={}
  end
  def self.config=(hash)
    @@config = hash
  end
end
