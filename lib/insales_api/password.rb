module InsalesApi
  module Password
    def self.create(secret, token, user_email = '', user_name = '', user_id = '')
      Digest::MD5.hexdigest("#{token}#{user_email}#{user_name}#{user_id}#{secret}")
    end
  end
end
