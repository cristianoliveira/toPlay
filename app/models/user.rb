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
  has_many :actions, class_name: 'Merit::Action'

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

  def owner?(object)
    self.id == object.user_id
  end

  # Merit Integration
  def has_already_scored_by?(target_id, action_method, target_model=nil)
    filter = { :target_id => target_id, :action_method => action_method }
    filter[:target_model] = target_model if target_model

    Merit::Action.where(filter).first
  end

  def points_for_topic(topic); points_for_topic_id(topic.id) end
  
  def points_for_topic_id(topic_id)
    sum = 0

    [ 'videos','resumes','questions','exercises'].map { |target|

      act = self.actions.where('target_model = ? and target_data like ?',
                              target,
                              "%topic_id: #{topic_id}%")

      act.map { |ac|
        ac.activity_logs.map { |al|
          sum += al.related_change.num_points.to_i
        }
      }
    }

    sum
  end

end
