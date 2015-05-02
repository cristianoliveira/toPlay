class Resume < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :description, presence: { message: 'Descrição deve ser informada' }
end
