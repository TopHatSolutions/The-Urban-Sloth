class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :full_name
      t.string :phone_number
      t.string :email_address
      t.string :street_address
      t.string :postal_code

      t.timestamps
    end
  end
end
