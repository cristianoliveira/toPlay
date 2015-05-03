module VotableOnce

  @@valid_score = false

  def once_liked_by(user)
    unvote_down user if user.voted_down_on? self

    user_have_upvoted = user.voted_up_on? self

    invalidate_score user_have_upvoted

    unless user_have_upvoted
      vote_up user
    else
      unvote_up user
    end
  end

  def once_disliked_by(user)
    unvote_up user if user.voted_up_on? self

    user_has_downvoted = user.voted_down_on? self

    invalidate_score user_has_downvoted

    unless user_has_downvoted
      vote_down user
    else
      unvote_down user
    end
  end

  def unliked_by(user)
    raise "Not allowed unlike."
  end

  def undisliked_by(user)
    raise "Not allowed undislike."
  end

  def invalidate_score(user_has_voted)
    @@valid_score = !user_has_voted
  end

  def valid_score?
    @@valid_score
  end

  def get_vote_score
    get_likes.size - get_dislikes.size
  end
end
