# reputation_change_observer.rb
class ReputationChangeObserver
  def update(changed_data)
    description = changed_data[:description]

    p "#{changed_data.to_json}"

    # If user is your meritable model, you can query for it doing:
    user = User.where(sash_id: changed_data[:sash_id]).first

    # When did it happened:
    datetime = changed_data[:granted_at]

    Notification.create(user: user, title: "Reputação", message: description )
  end
end
