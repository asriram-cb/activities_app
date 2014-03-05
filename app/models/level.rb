class Level < ActiveRecord::Base

  # relationships
  # validations
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :calorie_goal, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :activity_goal, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end