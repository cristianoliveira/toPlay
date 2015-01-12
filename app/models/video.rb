class Video < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  acts_as_votable

end
