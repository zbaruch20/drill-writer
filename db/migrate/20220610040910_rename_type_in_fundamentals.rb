class RenameTypeInFundamentals < ActiveRecord::Migration[7.0]
  def change
    rename_column :fundamentals, :type, :move_type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
