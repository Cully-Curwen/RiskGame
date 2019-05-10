require 'json'

class GameController < ApplicationController
  # TEST ROUTES
  def try
    puts "********************************************"
    puts Setup.STATE
    puts "********************************************"
  end

  def newUser
    puts "*******************************************"
    if Game.STATE[:users].count < 2
      User.new(name: "Greg", colour: "Blue")
      User.new(name: "Bob", colour: "Red")
    end
    puts "Complete"
    puts "*******************************************"
  end
  
  def quickGen
    if Game.STATE[:users].count < 2
      User.new(name: "Greg", colour: "Blue")
      User.new(name: "Bob", colour: "Red")
    end
    Setup.startGame
    render json: Game.gameState, status: :accepted
  end

  def fullGen
    if Game.STATE[:users].count < 2
      User.new(name: "Greg", colour: "Blue")
      User.new(name: "Bob", colour: "Red")
    end
    Setup.startGame
    Setup.fullStartBoard
    render json: Game.gameState, status: :accepted
  end
  # TEST ROUTES END
  
  def gameState
    render json: Game.gameState, status: :accepted
  end
  
  def nextPhase
    if params[:user_id] == Game.STATE[:currentPlayer].id
      Game.nextPhase
      render json: Game.gameState, status: :accepted
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end

  def endTurn
    if params[:user_id] == Game.STATE[:currentPlayer].id
      Game.endTurn
      render json: Game.gameState, status: :accepted
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end

end