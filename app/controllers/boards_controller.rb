class BoardsController < ApplicationController
  
  def index
    @boards = Board.all
  end

  def show
    
    begin
      @board = Board.find_by_url_title(params[:id])
    rescue
      render "public/404.html", :status => :not_found
    end
    
    @topics = Topic.paginate :conditions => ["board_id = ?", "#{@board[:id]}"], :order => "created_at DESC", :page => params[:page]
    
  end

end
