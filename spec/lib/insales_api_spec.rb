require 'spec_helper'

describe InsalesApi do

  describe '.wait_retry' do

    response_stub = Struct.new(:code, :retry_after) do
      def [](key)
        {'Retry-After' => retry_after}[key]
      end
    end

    it 'should not run without block' do
      expect do
        described_class.wait_retry(20, nil)
      end.to raise_error
    end

    it 'should handle succesfull request' do
      counter = 0
      described_class.wait_retry do
        counter += 1
      end

      expect(counter).to eq(1)
    end

    it 'should make specified amount of attempts' do
      counter = 0
      described_class.wait_retry(3) do
        counter += 1

        if counter < 3
          raise ActiveResource::ServerError.new(response_stub.new("429", "0"))
        end
      end

      expect(counter).to eq(3)
    end

    it 'should use callback proc' do
      callback = Proc.new{}
      counter = 0
      callback.should_receive(:call).with(0, 1, 3, instance_of(ActiveResource::ServerError))
      callback.should_receive(:call).with(0, 2, 3, instance_of(ActiveResource::ServerError))

      described_class.wait_retry(3, callback) do
        counter += 1

        if counter < 3
          raise ActiveResource::ServerError.new(response_stub.new("429", "0"))
        end
      end
    end

    it 'should pass attempt number to block' do
      last_attempt_no = 0
      described_class.wait_retry(3) do |x|
        last_attempt_no = x

        if last_attempt_no < 3
          raise ActiveResource::ServerError.new(response_stub.new("429", "0"))
        end
      end

      expect(last_attempt_no).to eq(3)
    end

    it 'should raise if no attempts left' do
      expect do
        described_class.wait_retry(3) do |x|
          raise ActiveResource::ServerError.new(response_stub.new("429", "0"))
        end
      end.to raise_error(ActiveResource::ServerError)
    end

    it 'should raise on user errors' do
      attempts = 0
      expect do
        described_class.wait_retry(3) do |x|
          attempts = x
          raise 'Some other error'
        end
      end.to raise_error(StandardError)
      expect(attempts).to eq(1)
    end

    it 'should raise on other server errors' do
      attempts = 0
      expect do
        described_class.wait_retry(3) do |x|
          attempts = x
          raise ActiveResource::ServerError.new(response_stub.new("502", "0"))
        end
      end.to raise_error(ActiveResource::ServerError)
      expect(attempts).to eq(1)
    end

    it 'should run until success' do |x|
      success = false
      described_class.wait_retry do |x|
        raise ActiveResource::ServerError.new(response_stub.new("429", "0")) if x < 10
        success = true
      end

      expect(success).to be_true
    end
  end

end
