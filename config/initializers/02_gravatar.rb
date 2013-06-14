#config/initializers/02_gravatar.rb
require 'gravatar_config'

GravatarConfig.config = YAML.load_file("config/gravatar.yml")[Rails.env].symbolize_keys
