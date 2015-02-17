class VideosController < InheritedResources::Base
  before_action :load_topics, only: :new  
  
  helper FlashAlertHelper

  def create

    topic = load_topics.first 

    video      = topic.videos.new(video_params)
    video.user = current_user

    if video.save
      redirect_to topic_path(topic)
    else
      error = video.errors.first
      flash[:message] = error

      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: { error: error } }
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
    params.require(:video).permit(:url, :title, :channel, :description)
  end

  def topic_params
    params.require(:topic)
  end

  def load_topics
    if params[:topic]
      @topics = Topic.where(id: topic_params)
    else  
      @topics = Topic.all
    end
  end
end
