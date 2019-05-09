require 'json'

class GameController < ApplicationController

  def reinforce
    if params[:user_id] == Game.STATE[:currentPlayer].id
      Reinforcement.reinforce(params[:territory_id], params[:armies])
      render json: Game.gameState, status: :accepted
    else
      render json: {error: 'Not your turn'}, status: 400
    end
  end

end