class AddBeforeStringAndAfterStringToDrills < ActiveRecord::Migration[7.0]
  def change
    add_column :drills, :before_string, :string
    add_column :drills, :after_string, :string
  end
end
