class Topic < ActiveRecord::Base
  belongs_to :level
  belongs_to :user
  has_many :videos
  has_many :resumes
  has_many :exercises
  has_many :questions

  acts_as_list scope: :level
end
