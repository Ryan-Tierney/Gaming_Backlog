class UsersController < ApplicationController

    get '/users' do
      @users = User.all 
      erb :'index'
    end
  
    get '/register' do 
      if !logged_in?
        erb :'users/register' 
      else
        redirect to "/" 
      end
    end
  
    post '/register' do 
      if 
        params[:username] == "" || params[:password] == ""
        flash[:error] = "You must fill out all fields to sign up."
        redirect to '/register'
      else
        user = User.new(:username => params[:username], :password => params[:password])
        user.save 
        session[:user_id] = user.id
        redirect to '/'
      end
    end
  
    get '/login' do 
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/register'
      end
    end
  
    post '/login' do 
     @user = User.find_by(:username => params[:username])
     if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect to "/"
     else
       flash[:error] = "Invalid username or password."
       redirect '/login'
     end
   end
  
    get '/logout' do 
      if logged_in?
        flash[:success] = "Thanks for stopping by!"
        session.clear
        redirect to '/login'
      else
        redirect to '/login'
      end
    end
    
  end