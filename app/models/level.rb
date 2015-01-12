class Level < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  has_many :topics, -> { order("position ASC") }

  acts_as_list scope: :subject
end
