# reputation_change_observer.rb
class ReputationChangeObserver
  def update(changed_data)
    
    # I will keep it as an example
    # action = Merit::Action.find(changed_data[:merit_action_id])
    # score = Merit::Score.find_by_id(changed_data[:merit_object][:score_id])
    # point = score.score_points
    #
    # target = YAML.load(action.target_data)

    description = changed_data[:description]
    user = User.where(sash_id: changed_data[:sash_id]).first

    Notification.create(user: user, title: "Reputação", message: description )
  end
end
