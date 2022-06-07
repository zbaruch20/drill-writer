class AddDefaultStyleToDrills < ActiveRecord::Migration[7.0]
  def change
    change_column_default :drills, :style, 0
  end
end
