class Question < ActiveRecord::Base
  has_many :answers, class_name: "Question", foreign_key: "parent_id"
  belongs_to :question, class_name: "Question"
  belongs_to :topic
  belongs_to :user

  validates_presence_of :description, message: "Pergunta deve ser informada."

  acts_as_votable
end
