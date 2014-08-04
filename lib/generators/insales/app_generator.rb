require 'rails/generators/base'
require 'rails/generators/active_record'

module Insales
  module Generators
    class AppGenerator < ActiveRecord::Generators::Base
      source_root ::File.expand_path('../../templates', __FILE__)

      def gems
        gem 'foreigner'
        gem 'slim'
        gem 'simple_form'
        gem 'bootstrap-sass', version: '~> 3.0.0'
        gem 'inherited_resources'
      end

      def bundle_install
        run 'bundle install'
        run 'rails generate simple_form:install --bootstrap'
        template 'initializers/simple_form_bootstrap.rb', 'config/initializers/simple_form_bootstrap.rb'
      end

      def copy_models
        %w(account product variant client order order_line).each do |model|
          template "models/#{model}.rb", "app/models/#{model}.rb"
        end
      end

      def copy_migrations
        %w(account product variant client order order_line).each do |model|
          file = "create_#{model.pluralize}.rb"
          migration_template "migrations/#{file}", "db/migrate/#{file}"
        end
      end

      def copy_controllers
        template 'controllers/cpanel_controller.rb',        'app/controllers/cpanel_controller.rb'
        template 'controllers/installations_controller.rb', 'app/controllers/cpanel/installations_controller.rb'
        template 'controllers/sessions_controller.rb',      'app/controllers/cpanel/sessions_controller.rb'
        template 'controllers/accounts_controller.rb',      'app/controllers/cpanel/accounts_controller.rb'
      end

      def copy_assets
        template 'assets/cpanel.js.coffee',     'app/assets/javascripts/cpanel.js.coffee'
        template 'assets/cpanel.css.scss',      'app/assets/stylesheets/cpanel.css.scss'
        template 'assets/login_form.js.coffee', 'app/assets/javascripts/login_form.js.coffee'
        template 'assets/login_form.css.scss',  'app/assets/stylesheets/login_form.css.scss'
        application <<-RUBY.strip_heredoc
          config.assets.precompile += %w(
                cpanel.js
                cpanel.css
                login_form.js
                login_form.css
              )
        RUBY
      end

      def copy_views
        directory 'views', 'app/views'
      end

      def copy_locales
        %w(en ru).each { |l| template "locales/#{l}.yml", "config/locales/insales.#{l}.yml" }
      end

      def copy_app_initializer
        template 'initializers/insales_app.rb', 'config/initializers/insales_app.rb'
      end

      def copy_patch_initializer
        template 'initializers/insales_api_patch.rb', 'config/initializers/insales_api_patch.rb'
        template 'lib/insales_api_patch.rb',          'lib/insales_api_patch.rb'
        template 'lib/insales_api_patch/app.rb',      'lib/insales_api_patch/app.rb'
      end

      def add_url_options
        application "Rails.application.routes.default_url_options[:host] = 'my-app.com'"
        application "Rails.application.routes.default_url_options[:host] = 'localhost:3000'", env: :development
      end

      def add_routes
        route <<-RUBY.strip_heredoc
          namespace :cpanel do
              resource :account

              resource :session do
                get :autologin
              end

              resource :instalation do
                post :install
                post :uninstall
              end
            end
        RUBY
      end
    end
  end
end
