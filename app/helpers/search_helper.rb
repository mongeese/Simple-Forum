module SearchHelper
  
  def paginate_by(topics, posts)
    if topics.count < posts.count
      topics
    else
      posts
    end
  end
  
end
