ActiveSupport.on_load(:insales_api) do
  app = self::App
  app.api_key           = 'my-app'
  app.api_secret        = 'secret'

  Rails.application.reload_routes!
  app.api_autologin_url = Rails.application.routes.url_helpers.autologin_cpanel_session_url
end
