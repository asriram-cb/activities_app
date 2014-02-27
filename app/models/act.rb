class Action < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  default_scope -> { order('completed DESC') }

  validates :completed, presence: true
  validates :minutes, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 300 }
  validates :user_id, presence: true
  validates :activity_id, presence: true
end
