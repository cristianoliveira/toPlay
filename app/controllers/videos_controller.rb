class VideosController < InheritedResources::Base
  def upvote
    @video = Video.find(params[:id])

    if current_user.voted_up_on? @video
      @video.unliked_by current_user
    else
      @video.liked_by current_user
    end


    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @video.get_upvotes.size.to_s.rjust(3, '0') } }
    end

  end

  def downvote
    @video = Video.find(params[:id])

    if current_user.voted_down_on? @video
      @video.undisliked_by current_user
    else
      @video.disliked_by current_user
    end

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @video.get_downvotes.size.to_s.rjust(3, '0') } }
    end
  end
end
