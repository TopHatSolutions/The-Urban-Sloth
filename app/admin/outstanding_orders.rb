ActiveAdmin.register_page "Outstanding Orders" do
  content do
    render 'dashboard/outstanding_orders', {:orders => Order.where(status: "new")}
  end
end
