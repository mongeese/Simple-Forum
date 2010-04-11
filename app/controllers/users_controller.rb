class UsersController < ApplicationController

  
  before_filter :protect

  def index
  
    @title = "Members"
    @users = all_users
  
  end
  
  def search
    
    if params[:terms].nil?
      redirect_to users_url
      return
    end
    
    @title = "Members Search: #{params[:terms]}"
    @letter = "#{params[:terms]}";
    @users = User.paginate :conditions => ["username LIKE ?", "#{@letter}%"], :order => "username ASC", :page => params[:page]
    
  end

  def show
    
    @user = User.find_by_username(params[:id])
    @title = "#{params[:id]}'s Profile"
    
    unless @user
      render "public/404.html"
      return
    end
    
    @topics = @user.topics.all( :select => "DISTINCT(id), *", :order => "created_at DESC", :limit => 5 )
    @posts = @user.posts.all( :order => "created_at DESC", :limit => 5, :group => "topic_id" )
    
  end

  def all_users
    @users = User.paginate :order => "username ASC", :page => params[:page]
  end

  def profile

    @title = "Update My Profile"
    @user = current_user

  end
  
  def update_email
    
    return unless request.post?
    
    @user = current_user
    
    if @user.update_attributes(params[:user])
      flash[:msg] = 'Your email address was updated successfully.';
    end

    redirect_to user_profile_url
    
  end
  
  def update_password
    
    return unless request.post?
    
    @user = current_user
      
    if @user.update_attributes(params[:user])
      @user.password = params[:user][:password]
      flash[:msg] = 'Your password was updated successfully.';
    end

    redirect_to user_profile_url
    
  end

end
