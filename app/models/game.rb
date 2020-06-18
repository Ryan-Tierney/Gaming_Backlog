class Game < ActiveRecord::Base 
    belongs_to :user 
    validates_presence_of :title, :developer
end 