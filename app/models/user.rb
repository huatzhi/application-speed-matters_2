class User < ActiveRecord::Base
  has_many :points

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :username,
            presence: true,
            length: { minimum: 2, maximum: 32 },
            format: { with: /^\w+$/, multiline: true },
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            format: { with: /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i, multiline: true },
            uniqueness: { case_sensitive: false }

  def recount_total_points
    self.points_sum = self.points.sum(:value)
    self.save
  end

  def self.by_total_points
    # joins(:points).group('users.id').order('SUM(points.value) DESC')
    # order('users.points_sum DESC')
    reorder(points_sum: :desc)
  end

  def total_points
    # self.points.sum(:value)
    self.points_sum
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.page(page=1)
    page_number = page.to_i
    if page_number <= 1
      limit(10)
    else
      offset = (page_number - 1) * 10
      limit(10).offset(offset)
    end
  end
end
