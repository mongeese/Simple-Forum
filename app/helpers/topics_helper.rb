module TopicsHelper

  def topic_link(topic)
    link_to topic.title, topic_url(topic)
  end
  
end
