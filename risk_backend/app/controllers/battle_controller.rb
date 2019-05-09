require 'json'

class BattleController < ApplicationController

  def attack
    if params[:user_id] == Game.STATE[:currentPlayer].id
      case Battle.attack(params[:base_territory_id], params[:target_territory_id], params[:armies])
      when 0
        render json: {gameState: Game.gameState, battleLock: Battle.LOCK}.to_json, status: :accepted
      when 1
        render json: {error: 'Cannot Attack From There'}, status: 400
      end
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end

  def continue_attack
    if params[:user_id] == Game.STATE[:currentPlayer].id
      case Battle.continueAttack(params[:continue_attack])
      when 0
        render json: {gameState: Game.gameState, battleLock: Battle.LOCK}.to_json, status: :accepted
      when 1
        render json: {error: 'Cannot Attack From There'}, status: 400
      end
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end

end