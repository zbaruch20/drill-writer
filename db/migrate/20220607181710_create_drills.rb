class CreateDrills < ActiveRecord::Migration[7.0]
  def change
    create_table :drills do |t|
      t.string :name
      t.text :description
      t.integer :style
      t.integer :ramp_cadences
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
