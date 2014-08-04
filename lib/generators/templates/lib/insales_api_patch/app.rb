class InsalesApi::App
  class << self
    def install(domain, token, insales_id)
      domain = prepare_domain(domain)
      if account = ::Account.find_by_insales_id(insales_id)
        if account.password.blank?
          account.update_attribute :password, password_by_token(token)
        end
        return true
      end
      ::Account.create(
        insales_domain:   domain,
        insales_password: password_by_token(token),
        insales_id:       insales_id,
      )
    end

    def uninstall(domain, password)
      account = ::Account.find_by_insales_domain(prepare_domain(domain))
      return true unless account
      return false if account.password != password
      account.destroy
    end
  end
end
