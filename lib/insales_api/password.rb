require 'digest/md5'
module InsalesApi
  module Password
    def self.create(secret, token)
      Digest::MD5.hexdigest("#{token}#{secret}")
    end
  end
end
