class UserChangeColumnAddDefaultToSumForUser < ActiveRecord::Migration
  def up
    change_column :users, :points_sum, :integer, default: 0
  end

  def down
    change_column :users, :points_sum, :integer
  end
end
