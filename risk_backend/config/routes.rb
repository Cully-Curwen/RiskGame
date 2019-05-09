Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'test', to: 'game#try'
  get 'users/new', to: 'game#newUser'
  get 'gen', to: 'game#quickGen'
  # Universal
  root to: 'game#gameState'
  get 'state', to: 'game#gameState'
  get 'next_phase', to: 'game#nextPhase'
  post 'end_turn', to: 'game#endTurn'
  # Setup Phase
  get 'lobby', to: 'setup#lobby'
  post 'connect', to: 'setup#connect'
  post 'start_game', to: 'setup#startGame'
  post 'deploy_armies', to: 'setup#deployArmies'
  # Reinforcement Phase
  post 'reinforce', to: 'reinforcement#reinforce'
  # Battle Phase
  post 'attack', to: 'battle#attack'
  post 'continue_attack', to: 'battle#continue_attack'
  # Redeployment Phase
  post 'redeploy', to: 'redeployment#redeploy'
end
