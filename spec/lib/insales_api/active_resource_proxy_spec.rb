require 'spec_helper'

describe InsalesApi::ActiveResourceProxy do
  let(:proxy) { described_class.new(configurer, object) }
  let(:configurer) { Object.new.tap { |x| x.stub(:init_api).and_yield } }

  describe '#method_missing' do
    let(:object) { {} }
    let(:method_name) { :some_method }
    subject { proxy.send(method_name) }

    it 'should proxy method to object & pass result through #proxy_for' do
      result1 = {test: :resut1}
      result2 = {test: :resut2}
      object.should_receive(method_name).and_return(result1)
      proxy.should_receive(:proxy_for).with(result1).and_return(result2)
      subject.should eq(result2)
    end
  end

  describe '::need_proxy?' do
    subject { described_class.need_proxy?(object) }

    context 'for scalar' do
      let(:object) { true }
      it { should be false }
    end

    context 'for array' do
      let(:object) { [] }
      it { should be true }
    end

    context 'for hash' do
      let(:object) { {} }
      it { should be true }
    end

    context 'for InsalesApi::Base class' do
      let(:object) { InsalesApi::Account }
      it { should be true }
    end

    context 'for InsalesApi::Base object' do
      let(:object) { InsalesApi::Account.new }
      it { should be true }
    end

    context 'for ActiveResource::Collection object' do
      let(:object) { ActiveResource::Collection.new }
      it { should be true }
    end

    context 'for ActiveResource::Base object' do
      let(:object) { ActiveResource::Base.new }
      it { should be false }
    end
  end
end
