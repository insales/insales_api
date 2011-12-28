require 'spec_helper'

describe InsalesApi::App do

  let :app do
    InsalesApi::App.new('my.shop.com', 'password')
  end

  describe "initialize" do
    it { app.shop.should be }
    it { app.password.should be }
    it { app.should_not be_authorized }
  end

  describe "configure_api" do
    it 'should set site and password for InsalesApi' do
      app.configure_api
      InsalesApi::Base.site.to_s.should =~ /#{app.shop}/
      InsalesApi::Base.password.should == app.password
    end
  end

  describe "salt" do
    it "should return md5 hexdigest" do
      app.salt.should be
      app.salt.length.should == Digest::MD5.hexdigest('test').length
    end
  end

  describe "store_auth_token" do
    it "should set auth_token" do
      app.store_auth_token.should == InsalesApi::Password.create(app.password, app.salt)
    end
  end

  describe "authorization_url" do
    it "should set auth_token and return url" do
      app.authorization_url.should == "http://#{app.shop}/admin/applications/#{InsalesApi::App.api_key}/login?token=#{app.salt}&login=http://#{InsalesApi::App.api_host}/#{InsalesApi::App.api_autologin_path}"
      app.auth_token.should be
    end
  end

  describe "authorize" do
    before :each do
      app.store_auth_token
    end
    it "should authorize by valid token" do
      app.authorize app.auth_token
      app.should be_authorized
    end

    it "should not authorize by invalid token" do
      app.authorize 'bad token'
      app.should_not be_authorized
    end
  end

  describe "password_by_token" do
    it "should generate password" do
      InsalesApi::App.password_by_token('test').should == InsalesApi::Password.create(InsalesApi::App.api_secret, 'test')
    end
  end
end
