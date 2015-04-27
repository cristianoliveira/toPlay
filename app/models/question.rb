class Question < ActiveRecord::Base
  has_many :answers, class_name: "Question", foreign_key: "parent_id"
  belongs_to :question, class_name: "Question"
  belongs_to :topic
  belongs_to :user

  validates_presence_of :description, message: "Pergunta deve ser informada."

  acts_as_votable

  def unliked_by(user)
    vote_down(user)
  end

  def liked_by(user)
    vote_up(user)
  end

  def has_answer?
    self.answers.size > 0
  end

  def main?
    self.parent_id.blank?
  end

end
