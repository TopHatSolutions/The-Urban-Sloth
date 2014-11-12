class CreateLifestyles < ActiveRecord::Migration
  def change
    create_table :lifestyles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
