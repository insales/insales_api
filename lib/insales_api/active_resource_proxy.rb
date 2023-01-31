module InsalesApi
  class ActiveResourceProxy
    class << self
      def need_proxy?(value)
        klass = value.is_a?(Class) ? value : value.class
        return true if klass < Base || klass <= ActiveResource::Collection

        false
      end
    end

    def initialize(configurer, subject)
      @configurer = configurer
      @subject    = subject
    end

    def respond_to_missing?(method_name, include_private)
      @subject.respond_to?(method_name, include_private) || super
    end

    def method_missing(method_id, *args, &block)
      @configurer.init_api { proxy_for @subject.send(method_id, *args, &block) }
    end

    private

    def proxy_for(value)
      return value unless self.class.need_proxy?(value)

      self.class.new(@configurer, value)
    end
  end
end
