class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  acts_as_voter

  mount_uploader :avatar, AvatarUploader

  has_many :courses
  has_many :alternatives
  has_many :exercises
  has_many :levels
  has_many :resumes
  has_many :subjects
  has_many :topics
  has_many :videos
  has_many :notifications

  before_create { |user| user.role = 'student' unless user.role }

  GENDERS = [["Masculino", 1], ["Feminino", 2]]

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def role?(r)
    role.include? r.to_s
  end

  def admin?
    self.role? :administrator
  end

  def moderator?
    self.role? :moderator
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user

    if user.nil?
      # Get the existing user from email if the OAuth provider gives us an email
      user = User.where(:email => auth.info.email).first

      # Create the user if it is a new registration
      if user.nil?
        user = User.new(
          first_name: auth.extra.raw_info.name,
          email: auth.info.email,
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end

      # Associate the identity with the user if not already
      if identity.user != user
        identity.user = user
        identity.save!
      end
    end

    # returns user
    user
  end

  def unread_notifications
    self.notifications.where(read:false)
  end

  # Merit Integration
  def has_already_scored_by?(target_id, action_method, target_model=nil)
    filter = { :target_id => target_id, :action_method => action_method }
    filter[:target_model] = target_model if target_model

    Merit::Action.where(filter).first
  end

  def scores_by_like
    self.add_points(5, category: 'un/like')
    self.notifications.create(title:'Reputação', message: 'Ganhou 5 pontos (like)')
  end

  def scores_by_unlike
    self.subtract_points(5, category: 'un/like')
    self.notifications.create(title:'Reputação', message: 'Perdeu 5 pontos (deslike)')
  end

end
