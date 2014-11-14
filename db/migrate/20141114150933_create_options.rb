class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :option_type
      t.string :option_value
      t.decimal :option_price

      t.timestamps
    end
  end
end
