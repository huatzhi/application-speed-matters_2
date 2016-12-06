class AddPointsSumToUser < ActiveRecord::Migration
  def change
    add_column :users, :points_sum, :integer
    add_index :users, :points_sum
  end
end
