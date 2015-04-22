module VideosHelper
  def render_topic_part(form, topic)
    if topic
      "#{label_tag "Tópico: %s" % topic.name}
       #{form.hidden_field :topic_id}".html_safe
    else
      render 'videos/form_topic_part', :form => form
    end
  end

end
