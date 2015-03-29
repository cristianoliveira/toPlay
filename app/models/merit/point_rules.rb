# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      # score 10, :on => 'users#create' do |user|
      #   user.bio.present?
      # end
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      # score 20, :on => [
      #   'comments#create',
      #   'photos#create'
      # ]
      #
      # score -10, :on => 'comments#destroy'

      # score 5, :on => ['videos#upvote','questions#upvote']
      # This rule is in user model

      # score -5, :on => ['videos#downvote', 'questions#downvote']
      # This rule is in user model

      score 50, :on => [
        'user_exercise_answers#create',
        'user_exercise_answers#update'
      ] do |user_exercise_answer|
        user_exercise_answer.incorrect!
      end

      score 50, :on => 'question#create'

      score 100, :on => [
        'user_exercise_answers#create',
        'user_exercise_answers#update'
      ] do |user_exercise_answer|
        user_exercise_answer.correct?
      end

      score 250, :on => ['resumes#create', 'resumes#update']

      score 250, :on => 'video#start_watch' do |video|
        video.is_valid_score?
      end

      score 500, :on => 'videos#create'



    end
  end
end
