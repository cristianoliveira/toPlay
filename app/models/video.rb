class Video < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  acts_as_votable

  validates :url, presence: { message: ":Informe a URL do vídeo."}
  validates :title, presence: { message: ":Informe o Título" }
  validates :topic_id, presence: { message: ":Informe o Tópico para o vídeo."}

  @@valid_score = true

  def liked_by(user)
    unvote_down user if user.voted_down_on? self

    unless user.voted_up_on? self
      vote_up(user)
      self.user.scores_by_like
    else
      unvote_up(user)
      self.user.scores_by_unlike
    end
  end

  def unliked_by(user)
    raise "Not allowed unlike."
  end

  def disliked_by(user)
    unvote_up user if user.voted_up_on? self

    unless user.voted_down_on? self
      vote_down(user)
      self.user.scores_by_unlike
    else
      unvote_down(user)
      self.user.scores_by_like
    end
  end

  def undisliked_by(user)
    raise "Not allowed undislike."
  end

  def get_vote_score
    get_dislikes.size + get_likes.size
  end

  def invalidate_score!
    @@valid_score = false
  end

  def is_valid_score?
    @@valid_score
  end

end
