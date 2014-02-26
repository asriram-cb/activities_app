class Action < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  validates :completed, presence: true
end
