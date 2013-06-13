module AuthenticationMacro
  
  include Devise::TestHelpers
  
  def login_approved
    @request.env["devise.mapping"] = Devise.mappings[:approved]
    sign_in users(:approved)
  end
  
  def login_unapproved
    @request.env["devise.mapping"] = Devise.mappings[:unapproved]
    sign_in users(:unapproved)
  end

end