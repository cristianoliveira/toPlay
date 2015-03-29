class Question < ActiveRecord::Base
  has_many :answers, class_name: "Question", foreign_key: "parent_id"
  belongs_to :question, class_name: "Question"
  belongs_to :topic
  belongs_to :user

  validates_presence_of :description, message: "Pergunta deve ser informada."

  acts_as_votable

  def unliked_by(user)
    vote_down(user)
    self.user.scores_by_unlike
  end

  def liked_by(user)
    vote_up(user)
    self.user.scores_by_like
  end

end
