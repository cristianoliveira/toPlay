class TopicsController < InheritedResources::Base

  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_up, only: [:show, :delete, :edit]
  before_action :set_menu

  def level_topics
    @topics = Topic.where(level_id: params[:level_id])
    respond_to do |format|
      format.json { render json: @topics }
    end
  end

  def get_for_menu
    @topics = Topic.where(level_id: params[:level_id])
    result = @topics.map{|topic| { "value" => topic,
                                   "url" => url_for(controller: "topics",
                                                    action: "show",
                                                    id: topic.id)
                               }
                         }
    respond_to do |format|
      format.json { render json: { :result => result } }
    end
  end

  private
  def set_up
    topic = Topic.find(topic_params)
    @video = topic.videos.new
    @question = Question.new
    @resume = Resume.find_by_topic_id(topic.id)
    @resume = Resume.new unless @resume
  end

  def set_menu
    @show_menu = true
  end

  def topic_params
    params.require(:id)
  end

end
