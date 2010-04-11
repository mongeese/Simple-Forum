class SessionsController < ApplicationController
  
  
  before_filter :protect, :except => [:register, :login, :logout, :password]
  
  def register
    
    @title = 'Register'
    
    if request.post?
      
      @user = User.new(params[:user])
      
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_url
      end
      
    end
    
  end

  def login
    
    @title = 'Login'
    
    if request.post? 
      begin
        
        if user = User.authenticate( params[:user][:username], params[:user][:password] )
          session[:user_id] = user.id
          redirect_to root_url
        else
          flash.now[:error] = 'Your username or password was incorrect.'
        end
        
      rescue
        flash.now[:error] = "#{$!}"
      end
      
    end
    
  end
  
  def logout
    
    session[:user_id] = nil
    redirect_to root_url
    
  end

  def password
    
    if request.post?
      
      if user = User.find_by_email( params[:user][:email] )
        
        new_password = Digest::SHA1.hexdigest( Time.now.to_s )[0,14]
        
        user.password = new_password
        user.save
        
        UserMailer.deliver_password_reset( user, new_password )
        flash.now[:msg] = 'Your password has been sent to your email address.'
        
      else
        flash.now[:error] = 'Your email address could not be found.'        
      end
      
    end

  end

end
