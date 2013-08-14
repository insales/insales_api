module InsalesApi
  class RecurringApplicationCharge < Base
    def self.current
      find(:one, :from => '/admin/recurring_application_charge.xml')
    end

    def update
      connection.post('/admin/recurring_application_charge.xml',
                      encode,
                      self.class.headers).tap do |response|
        load_attributes_from_response(response)
      end
    end

    def delete
      connection.delete('/admin/recurring_application_charge.xml')
    end
  end
end
