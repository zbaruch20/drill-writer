class AddStringToMoves < ActiveRecord::Migration[7.0]
  def change
    add_column :moves, :string, :string
  end
end
