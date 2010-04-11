class TopicsController < ApplicationController

  before_filter :protect
  
  def index
    redirect_to root_url
  end
  
  def create
    
    @topic = Topic.create(params[:topic])
    @topic.user = current_user
    
    if @topic.save
      redirect_to :action => 'index'
    else
      render :new
      return
    end
    
  end
  
  def new
    @topic = Topic.new
    @boards = Board.all
  end
  
  def show
    
    begin
      @topic = Topic.find_by_url_title(params[:id])
    rescue
      render "public/404.html", :status => :not_found
    end
    
    @posts = @topic.posts.paginate :order => "created_at ASC", :page => params[:page]
     
  end
  
  def reply
    
    @post = Post.create(params[:post])
    @post.topic_id = params[:id]
    @post.user = current_user
    @post.save
    
    redirect_to topic_url(@post.topic)
    
  end

end
