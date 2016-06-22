Rails.application.routes.draw do
  get 'home/index'

  get 'home/search'

  root 'home#ping'
  post 'search' => 'home#search'

end
