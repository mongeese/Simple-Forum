class SearchController < ApplicationController
  
  POSTS_PER_PAGE = 20
  TOPICS_PER_PAGE = 20
  
  def index
  end
  
  def results
      
      if params[:q].empty?
        flash[:error] = 'Please enter a search term.'
        redirect_to :controller => 'Search', :action => :index
        return
      end
      
      if request.post?       
        redirect_to :controller => 'Search', :action => :results, :q => params[:q]
      end
      
      @topics = Topic.find_with_ferret( params[:q], { :per_page => TOPICS_PER_PAGE, :page => params[:page] }, { :order => 'created_at DESC' } )
      @posts = Post.find_with_ferret( params[:q], { :per_page => POSTS_PER_PAGE, :page => params[:page] }, { :order => 'created_at DESC' } )
      
  end

end
