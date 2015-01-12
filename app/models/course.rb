class Course < ActiveRecord::Base
  has_many :subjects, -> { order("position ASC") }
  belongs_to :user
end
