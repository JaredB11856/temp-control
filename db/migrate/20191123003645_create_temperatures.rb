class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.decimal :sensor, precision: 5, scale: 2, null: false

      t.timestamps
    end
  end
end
