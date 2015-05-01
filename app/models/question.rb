class Question < ActiveRecord::Base
  has_many :answers, class_name: "Question", foreign_key: "parent_id"
  belongs_to :question, class_name: "Question"
  belongs_to :topic
  belongs_to :user

  validates_presence_of :description, message: "Pergunta deve ser informada."

  # Votable
  acts_as_votable
  include VotableOnce

  # delegate :liked_by, :to => :once_liked_by
  def liked_by(user); once_liked_by user end
  # delegate :disliked_by, :to => :once_disliked_by
  def disliked_by(user); once_disliked_by user end

  # General Methods
  def has_answer?
    self.answers.size > 0
  end

  def main?
    self.parent_id.blank?
  end

end
