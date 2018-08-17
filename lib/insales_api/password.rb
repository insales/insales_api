module InsalesApi
  module Password
    def self.create(secret, token, user_email = '', user_name = '', user_id = '', email_confirmed = '')
      Digest::MD5.hexdigest("#{token}#{user_email}#{user_name}#{user_id}#{email_confirmed}#{secret}")
    end
  end
end
