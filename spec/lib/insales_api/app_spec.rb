require 'spec_helper'

describe InsalesApi::App do
  let(:domain) { 'my.shop.com' }
  let(:password) { 'password' }
  let(:app) { InsalesApi::App.new(domain, password) }

  subject { app }

  describe '#initialize' do
    its(:domain) { should eq(domain) }
    its(:password) { should eq(password) }
    its(:authorized?) { should be false }
  end

  describe '#configure_api' do
    it 'configures InsalesApi::Base' do
      InsalesApi::Base.should_receive(:configure).with(described_class.api_key, domain, password)
      app.configure_api
    end
  end

  describe '#salt' do
    its(:salt) { should be }
  end

  describe '#auth_token' do
    its(:auth_token) { should eq(InsalesApi::Password.create(app.password, app.salt)) }
  end

  describe 'authorization_url' do
    subject { app.authorization_url }
    let(:expected) do
      URI::Generic.build(
        scheme:   'http',
        host:     domain,
        path:     "/admin/applications/#{app.api_key}/login",
        query:    {
          token:  app.salt,
          login:  app.api_autologin_url,
        }.to_query,
      ).to_s
    end
    it { should eq(expected) }
  end

  describe '#authorize' do
    before { app.auth_token }
    subject { app.authorize(token) }

    context 'when valid token is given' do
      let(:token) { app.auth_token }
      it { should be true }
    end

    context 'when invalid token is given' do
      let(:token) { 'bad_token' }
      it { should be false }
    end
  end

  describe '::password_by_token' do
    let(:token) { 'test' }
    subject { InsalesApi::App.password_by_token(token) }
    it { should eq(InsalesApi::Password.create(InsalesApi::App.api_secret, token)) }
  end
end
