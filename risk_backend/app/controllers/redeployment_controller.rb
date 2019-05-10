require 'json'

class RedeploymentController < ApplicationController

  def redeploy
    if params[:user_id] == Game.STATE[:currentPlayer].id
      case Redeployment.redeploy(params[:base_territory_id], params[:target_territory_id], params[:armies])
      when 0
        render json: {gameState: Game.gameState, reinforcementLock: Redeployment.LOCK}.to_json, status: :accepted
      when 1
        render json: {error: 'Cannot Reinforce From There'}, status: 400
      end
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end

end