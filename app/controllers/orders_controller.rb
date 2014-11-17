class OrdersController < InheritedResources::Base

  private

    def order_params
      params.require(:order).permit(:belongs_to, :has_many, :status, :pst_rate, :gst_rate, :hst_rate, :total, :sub_total, :customer_id)
    end
end

