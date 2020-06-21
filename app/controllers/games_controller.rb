class GamesController < ApplicationController

    get '/games' do 
        if logged_in? 
            @user = current_user 
            session[:user_id] = @user.id 
            @games = current_user.games
            erb :'games/games' 
        else 
            redirect to '/login'
        end 
    end 

    get '/games/new' do
        if logged_in?
            erb :'games/new'
        else
            redirect to 'login'
        end 
    end 

    post '/games' do 
        if params[:title] == "" || params[:platform] == "" 
            flash[:error] = "Oops, you need to fill out all the fields."
            redirect to "games/new"
        else 
            @game = current_user.games.build(title: params[:title], developer: params[:developer])
            @game.save 
            flash[:success] = "Your game was added to your backlog"
            redirect to "/games/#{@game.id}"
        end 
    end

    get '/games/:id' do 
        if logged_in? 
            @game = Game.find_by_id(params[:id])
            erb  :'games/show'
        else 
            redirect to '/login' 
        end 
    end 

    get '/games/:id/edit' do 
        @game = Game.find_by_id(params[:id])
        if @game.user_id == session[:user_id] 
            erb :'/games/edit' 
        else 
            flash[:error] = "#{game.title} is not part of you're backlog"
            redirect to '/games'
        end 
    end 

    patch '/games/:id' do 
        @game = Game.find_by_id(params[:id])
        @game && @game.user == current_user 
        if params[:title] == "" || params[:developer] == ""
          flash[:error] = "Please fill all fields"
          redirect to '/games'
        else
          @game.update(title: params[:title], developer: params[:developer]) 
          @game.save
          flash[:success] = "#{@game.title} was successfully updated"
          redirect to '/games'
        end
      end

    delete '/games/:id/delete' do 
        @game = Game.find_by_id(params[:id])
        if @game && @game.user == current_user
            @game.delete
            flash[:success] = "#{@game.title} was deleted successfully"
            redirect to '/games'
        else
            flash[:error] = "This game does not belong to you"
        end 
    end 

end 