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
      render json: {gameLive: Game.LIVE, setupReady: Setup.READY}.to_json, status: :accepted
    else
      render json: {gameLive: Game.LIVE, setupReady: Setup.READY}.to_json, status: :accepted
    end
  end

  def deployArmies
    if params[:user_id] == Game.STATE[:currentPlayer]
      render json: {error: 'Not your turn'}, status: 401
    end
    user_id = params[:user_id]
    ter_id = params[:territory_id]
    armies = params[:armies]
    terArr = Game.usersTerritoriesIds

    if terArr.include?(ter_id)
      Setup.placeTroops(ter_id, armies)
      render json: {gameState: Game.STATE, setupState: Setup.STATE}.to_json, status: :accepted
    else
    end
  end

  private
  def connect_params
    params.require(:user).permit(:name, :colour)
  end

end