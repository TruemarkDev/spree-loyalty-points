module Spree
  class PaymentMethod::LoyaltyPoints < PaymentMethod
    def actions
      %w{capture void}
    end

    def can_void?(payment)
      payment.state != 'void'
    end

    def can_capture?(payment)
      ['checkout', 'pending'].include?(payment.state)
    end

    def capture(payment, source, gateway)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def void(source, gateway)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def source_required?
      false
    end

    private

      def get_order(order_id)
        actual_order_id = order_id.split('-').first
        Spree::Order.find_by_number(actual_order_id)
      end

  end
end
