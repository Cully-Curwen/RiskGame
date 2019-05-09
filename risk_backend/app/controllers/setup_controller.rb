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
    render json: Game.STATE[:users].to_json, status: :accepted
  end

  def startGame
    user_id = params[:user_id]
    ready = params[:ready]
    Setup.STATE[user_id] = ready
    test =  Setup.STATE.map{ |key, value| value }
    if !test.includes?(false)
      Setup.startGame
      render json: {gameState: Game.STATE, setupReady: Setup.READY}.to_json, status: :accepted
    else
      render json: {gameState: Game.STATE, setupReady: Setup.READY}.to_json, status: :accepted
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