class Question < ActiveRecord::Base
  has_many :answers, class_name: "Question", foreign_key: "parent_id"
  belongs_to :question, class_name: "Question"
  belongs_to :topic
  belongs_to :user

  validates_presence_of :description, message: "Pergunta deve ser informada."

  acts_as_votable

  def liked_by(user)
    unvote_down user if user.voted_down_on? self

    unless user.voted_up_on? self
      vote_up(user)
    else
      unvote_up(user)
    end
  end

  def unliked_by(user)
    raise "Not allowed unlike."
  end

  def disliked_by(user)
    unvote_up user if user.voted_up_on? self

    unless user.voted_down_on? self
      vote_down(user)
    else
      unvote_down(user)
    end
  end

  def undisliked_by(user)
    raise "Not allowed undislike."
  end

  def has_answer?
    self.answers.size > 0
  end

  def main?
    self.parent_id.blank?
  end

end
