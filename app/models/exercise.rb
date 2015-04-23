class Exercise < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :alternatives
  mount_uploader :cover, ExerciseUploader

  delegate :level, :to => :topic, :allow_nil => true
  delegate :subject, :to => :level, :allow_nil => true
  delegate :course, :to => :subject, :allow_nil => true

  def name
    return self.description.truncate(100)
  end

  def alternative(index)
    a = self.alternatives[index]
    a ||= self.alternatives.new
  rescue
    self.alternatives.new
  end

  def correct_alternative?(index)
    alternative(index).correct
  end

end
