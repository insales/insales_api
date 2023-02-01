# frozen_string_literal: true

require 'spec_helper'

describe InsalesApi::App do
  subject(:app) { described_class.new(domain, password) }

  let(:domain) { 'my.shop.com' }
  let(:password) { 'password' }

  describe '#initialize' do
    it { expect(app.domain).to eq(domain) }
    it { expect(app.password).to eq(password) }
    it { expect(app.authorized?).to be false }
  end

  describe '#configure_api' do
    it 'configures InsalesApi::Base' do
      allow(InsalesApi::Base).to receive(:configure).with(described_class.api_key, domain, password)
      app.configure_api
      expect(InsalesApi::Base).to have_received(:configure).with(described_class.api_key, domain, password)
    end
  end

  describe '#salt' do
    it { expect(app.salt).to be_present }
  end

  describe '#auth_token' do
    it { expect(app.auth_token).to eq(InsalesApi::Password.create(app.password, app.salt)) }
  end

  describe 'authorization_url' do
    subject { app.authorization_url }

    let(:expected) do
      URI::Generic.build(
        scheme: 'http',
        host: domain,
        path: "/admin/applications/#{app.api_key}/login",
        query: {
          token: app.salt,
          login: app.api_autologin_url
        }.to_query
      ).to_s
    end

    it { is_expected.to eq(expected) }
  end

  describe '#authorize' do
    subject { app.authorize(token) }

    before { app.auth_token }

    context 'when valid token is given' do
      let(:token) { app.auth_token }

      it { is_expected.to be true }
    end

    context 'when invalid token is given' do
      let(:token) { 'bad_token' }

      it { is_expected.to be false }
    end
  end

  describe '::password_by_token' do
    subject { described_class.password_by_token(token) }

    let(:token) { 'test' }

    it { is_expected.to eq(InsalesApi::Password.create(described_class.api_secret, token)) }
  end
end
