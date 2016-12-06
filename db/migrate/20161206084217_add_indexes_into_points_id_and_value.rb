class AddIndexesIntoPointsIdAndValue < ActiveRecord::Migration
  def change
    add_index :points, :user_id
    add_index :points, :value
  end
end
