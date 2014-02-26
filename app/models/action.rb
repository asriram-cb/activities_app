class Action < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  validates :completed, presence: true
  validates :user_id, presence: true
  validates :activity_id, presence: true
end
