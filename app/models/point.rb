class Point < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :label, presence: true

  after_save :reset_user_count
  after_destroy :reset_user_count

  private
  def reset_user_count
    self.user.recount_total_points
  end

end
