class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :name
      t.text :description
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end
