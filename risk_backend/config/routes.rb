Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/test', to: 'game#try'
  get 'users/new', to: 'game#newUser'
  get 'gen', to: 'game#quickGen'
  # Universal
  get 'state', to: 'game#gameState'
  post 'end_turn', to: 'endTurn#gameState'
  # Setup Phase
  post 'start_game', to 'setup#startGame'
  post 'connect', to 'setup#connect'
  post 'deploy_armies', to 'setup#deployArmies'
end
