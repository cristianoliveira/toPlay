module ActAsVotableHelper

  def show_downvotes(vatable_object)
    vatable_object.get_downvotes.size.to_s.rjust(3, '0')
  end

  def show_upvotes(vatable_object)
    vatable_object.get_upvotes.size.to_s.rjust(3, '0')
  end

  def show_total_votes(vatable_object)
    total = vatable_object.get_upvotes.size - vatable_object.get_downvotes
    total.to_s.rjust(3, '0')
  end


end
