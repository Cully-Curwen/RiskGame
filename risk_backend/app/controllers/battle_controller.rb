require 'json'

class GameController < ApplicationController

  def attack
    if params[:user_id] == Game.STATE[:currentPlayer].id
      Battle.attack(params[:base_territory_id], params[:target_territory_id], params[:armies])
      render json: Game.gameState, status: :accepted
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end

  def continue_attack
    if params[:user_id] == Game.STATE[:currentPlayer].id
      Battle.continueAttack(params[:continue_attack])
      render json: Game.gameState, status: :accepted
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end
end