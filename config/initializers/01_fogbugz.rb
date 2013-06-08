#config/initializers/01_fogbugz.rb
require 'fogbugz_config'

FogbugzConfig.config = YAML.load_file("config/fogbugz.yml")[Rails.env].symbolize_keys
