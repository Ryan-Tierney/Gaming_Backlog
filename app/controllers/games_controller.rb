class GamesController < ApplicationController

    get '/games' do 
        if logged_in? 
            @user = current_user 
            session[:user_id]
        end 
    end 

end 