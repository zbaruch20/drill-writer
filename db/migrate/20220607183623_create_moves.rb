class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.integer :num_eights
      t.integer :position
      t.references :drill, null: false, foreign_key: true
      t.references :fundamental, null: false, foreign_key: true

      t.timestamps
    end
  end
end
