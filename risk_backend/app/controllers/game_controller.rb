class GameController < ApplicationController

  def try
    puts "********************************************"
    if Game.STATE[:users].empty?
      puts "users empty"
    else
      puts "users are:"
      Game.STATE[:users].map{|user| puts user.name}
    end
    puts "********************************************"
  end

  def newUser
    puts "*******************************************"
    if Game.STATE[:users].count < 2
      User.new(id: 1, name: "Greg", colour: "Blue")
      User.new(id: 2, name: "Bob", colour: "Red")
    end
    puts "Complete"
    puts "*******************************************"
  end
  
  def quickGen
    if Game.STATE[:users].count < 2
      User.new(id: 1, name: "Greg", colour: "Blue")
      User.new(id: 2, name: "Bob", colour: "Red")
    end
    Setup.startGame
  end

  def gameState
    render json: Game.gameState, status: :accepted
  end

  def endTurn
    user_id = params[:user_id]
    if user_id == GAME.STATE[:currentPlayer].id
      Game.nextPlayer
      render json: Game.gameState,
    else
      render json: {error: 'Not your turn'}, status: 401
    end
  end

end