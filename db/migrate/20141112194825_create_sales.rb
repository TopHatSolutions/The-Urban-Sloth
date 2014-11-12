class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.int :percentage
      t.date :start_date
      t.date :finish_date

      t.timestamps
    end
  end
end
