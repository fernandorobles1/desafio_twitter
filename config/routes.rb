Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "home#index"
  get '/home/hashtag/:name', to: 'home#hashtags'

  devise_for :users, controllers: {
        registrations: 'users/registrations'}
  
  resources :tweets do
    post :retweet
    resources :likes
    post :friendship
    delete :unfriendship
  end

  get 'api/news', to: 'api#news'
  post 'api/tweets', to: 'api#create'
end
