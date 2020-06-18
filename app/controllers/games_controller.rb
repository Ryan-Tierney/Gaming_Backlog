class GamesController < ApplicationController

    get '/games' do 
        if logged_in? 
            @user = current_user 
            session[:user_id] = @user.id 
            @games = Game.all 
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

end 