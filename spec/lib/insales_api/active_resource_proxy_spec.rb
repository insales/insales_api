# frozen_string_literal: true

require 'spec_helper'

describe InsalesApi::ActiveResourceProxy do
  let(:proxy) { described_class.new(configurer, object) }
  let(:configurer) { Object.new.tap { |x| x.stub(:init_api).and_yield } }

  describe '#method_missing' do
    subject(:result) { proxy.send(method_name) }

    let(:object) { {} }
    let(:method_name) { :some_method }

    it 'proxies method to object & pass result through #proxy_for' do
      result1 = { test: :resut1 }
      result2 = { test: :resut2 }
      object.should_receive(method_name).and_return(result1)
      proxy.should_receive(:proxy_for).with(result1).and_return(result2)
      expect(result).to eq(result2)
    end
  end

  describe '::need_proxy?' do
    subject { described_class.need_proxy?(object) }

    context 'when object is scalar' do
      let(:object) { true }

      it { is_expected.to be false }
    end

    context 'when object is InsalesApi::Base class' do
      let(:object) { InsalesApi::Account }

      it { is_expected.to be true }
    end

    context 'when object is InsalesApi::Base object' do
      let(:object) { InsalesApi::Account.new }

      it { is_expected.to be true }
    end

    context 'when object is ActiveResource::Collection object' do
      let(:object) { ActiveResource::Collection.new }

      it { is_expected.to be true }
    end

    context 'when object is ActiveResource::Base object' do
      let(:object) { ActiveResource::Base.new }

      it { is_expected.to be false }
    end
  end
end
