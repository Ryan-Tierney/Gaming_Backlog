class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t| 
      t.string :title 
      t.string :developer
    end 
  end
end
