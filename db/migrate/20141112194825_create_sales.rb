class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.integer :percentage
      t.date :start_date
      t.date :finish_date

      t.timestamps
    end
  end
end
