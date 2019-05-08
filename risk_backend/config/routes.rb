Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/test', to: 'game#try'
  get 'users/new', to: 'game#newUser'
  get 'start', to: 'game#startGame'
  get 'state', to: 'game#gameState'
end
