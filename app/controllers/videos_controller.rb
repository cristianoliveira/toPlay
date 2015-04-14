class VideosController < InheritedResources::Base
  respond_to :html, :json
  before_action :authenticate_user!

  def show
    @video = Video.find_by_id(params[:id])
    render layout: false
  end

  def update
    @video = Video.find_by_id(params[:id])
    respond_to do |format|
      if @video.update(video_params)
        respond_to do |format|
          format.html { redirect_to topic_path(@video.topic_id) }
          format.json {
            render json: {
              result: 'ok'
            }
          }
        end
      else
        respond_to do |format|
          format.html {  flash[:message] = @video.errors.full_messages
                         redirect_to :back }
          format.json { render json:  @video.errors.full_messages , status: 422 }
        end
      end
    end
  end

  def destroy
    @video = Video.find_by_id(params[:id])

    if  @video
      unless @video.delete
        flash[:message] = @video.errors.full_messages
      end
    else
      flash[:message] = 'Video não foi encontrado'
    end

    redirect_to :back
  end

  def create
    @video      = Video.new(video_params)
    @video.user = current_user

    if @video.save
      respond_to do |format|
        format.html { redirect_to topic_path(@video.topic_id) }
        format.json {
          render json: {
            result: 'ok',
            redirect_to: topic_path(@video.topic_id)
          }
        }
      end

    else
      respond_to do |format|
        format.html {  flash[:message] = @video.errors.full_messages
                       redirect_to :back }
        format.json { render json:  @video.errors.full_messages , status: 422 }
      end
    end
  end

  def upvote
    @video = Video.find(params[:id])

    @video.liked_by current_user

    respond_to do |format|
      format.html {redirect_to :back }
      format.json {
        render json: {
          count: @video.get_vote_score.to_s.rjust(3, '0')
        }
      }
    end

  end

  def downvote
    @video = Video.find(params[:id])

    @video.disliked_by current_user

    respond_to do |format|
      format.html { redirect_to :back }
      format.json {
        render json: {
          count: @video.get_vote_score.to_s.rjust(3, '0')
        }
      }
    end
  end

  def start_watch
    video = Video.find(params[:id])

    if current_user.has_already_scored_by?(video.id, 'start_watch')
      video.invalidate_score!
      result = { result: true }
    else
      result = { result: false }
    end

    respond_to do |format|
      format.json { render json: { :result => result } }
    end
  end

  private
  def video_params
    params.require(:video).permit(:id,
    :topic_id,
    :url,
    :title,
    :channel,
    :description)
  end
end
