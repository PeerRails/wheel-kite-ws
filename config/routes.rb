Rails.application.routes.draw do
  root 'home#ping'
  post 'search' => 'home#search'

end
