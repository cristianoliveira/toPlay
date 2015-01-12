class Subject < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :levels, -> { order("position ASC") }

  acts_as_list scope: :course
end
