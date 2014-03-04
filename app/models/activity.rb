class Activity < ActiveRecord::Base

  # relationships
  has_many :acts
  has_many :users, through: :acts

  # validations
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :heart_rate, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 50, less_than_or_equal_to: 220 }
end
