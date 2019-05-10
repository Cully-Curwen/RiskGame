require 'json'

class SetupController < ApplicationController

  def connect
    puts connect_params
    if connect_params[:name] && connect_params[:colour]
      playerReg = User.new(name: connect_params[:name], colour: connect_params[:colour])
      render json: playerReg.to_json, status: :accepted
    else
      render json: {error: 'Wrong Details'}, status: 400
    end
  end

  def lobby
    render json: {users: Game.STATE[:users], live: Game.STATE[:live]}.to_json, status: :accepted
  end

  def startGame
    case Setup.readyUp(params[:user_id], params[:ready])
    when 0
      render json: {gameState: Game.STATE}.to_json, status: :accepted
    when 1
      render json: {gameState: Game.STATE, setupReady: Setup.STATE}.to_json, status: :accepted
    when 2
      render json: {error: "something has gone wrong"}.to_json, status: 500
    end
  end

  def deployArmies
    if params[:user_id] != Game.STATE[:currentPlayer].id
      render json: {error: 'Not your turn'}, status: 401
    end
    code = Setup.deploy(params[:territory_id], params[:armies])
    case code
    when 0
      render json: Game.gameState, status: :accepted
    when 1
      render json: {error: 'Not one of your territories'}, status: 401
    end
  end

  private
  def connect_params
    params.require(:user).permit(:name, :colour)
  end

end