require 'digest/md5'

module GravatarHelper
  
  def gravatar_url user, size_type
    hash = Digest::MD5.hexdigest(user.email)
    extension = GravatarConfig.config[:show_extension] ? '.jpg' : ''
    size = GravatarConfig.config[size_type]
    default_image = GravatarConfig.config[:default_image]
    rating = GravatarConfig.config[:rating]
    force_default = GravatarConfig.config[:force_default] ? '&f=y' : ''
    
    return "http://www.gravatar.com/avatar/#{hash}#{extension}?s=#{size}&d=#{default_image}&r=#{rating}#{force_default}"
  end
  
end
