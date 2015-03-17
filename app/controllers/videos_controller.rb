class VideosController < InheritedResources::Base
  respond_to :html, :json
  before_action :authenticate_user!

  helper FlashAlertHelper

  def create
    video      = Video.new(video_params)
    video.user = current_user

    if video.save
      respond_to do |format|
        format.html { redirect_to topic_path(video.topic_id) }
        format.json { render json: { result: 'ok', redirect_to: topic_path(video.topic_id) } }
      end

    else
      error = video.errors

      respond_to do |format|
        format.html {  flash[:message] = error.full_messages
                       redirect_to :back }
        format.json { render json:  error.full_messages , status: 422 }
      end
    end
  end

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

  private
  def video_params
    params.require(:video).permit(:topic_id, :url, :title, :channel, :description)
  end
end
