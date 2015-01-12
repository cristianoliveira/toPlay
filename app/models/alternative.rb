class Alternative < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :user
end
