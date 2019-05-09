Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'test', to: 'game#try'
  get 'users/new', to: 'game#newUser'
  get 'gen', to: 'game#quickGen'
  # Universal
  root to: 'game#gameState'
  get 'state', to: 'game#gameState'
  post 'end_turn', to: 'game#endTurn'
  # Setup Phase
  get 'lobby', to: 'setup#lobby'
  post 'connect', to: 'setup#connect'
  post 'start_game', to: 'setup#startGame'
  post 'deploy_armies', to: 'setup#deployArmies'
end
