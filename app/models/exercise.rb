class Exercise < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :alternatives
  mount_uploader :cover, ExerciseUploader

  def name
    return self.description.truncate(100)
  end

end
