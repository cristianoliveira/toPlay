class Video < ActiveRecord::Base
  acts_as_votable
  include VotableOnce

  belongs_to :topic
  belongs_to :user

  delegate :level, :to => :topic, :allow_nil => true
  delegate :subject, :to => :level, :allow_nil => true
  delegate :course, :to => :subject, :allow_nil => true


  validates :url, presence: { message: ":Informe a URL do vídeo."}
  validates :title, presence: { message: ":Informe o Título" }
  validates :topic_id, presence: { message: ":Informe o Tópico para o vídeo."}

  # delegate :liked_by, :to => :once_liked_by
  def liked_by(user); once_liked_by user end
  # delegate :disliked_by, :to => :once_disliked_by
  def disliked_by(user); once_disliked_by user end

end
