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
      @user = User.create(username: params[:username], password: params[:password]) 
      @user.save
       if @user.valid?
         session[:user_id] = @user.id 
         redirect "/games"
       elsif @user.invalid? && User.find_by(username: @user.username)
         flash[:error] = "That username is already taken, please choose another."
         redirect to '/register'
       else
         flash[:error] = "You must fill out all fields to sign up."
         redirect to '/register'
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