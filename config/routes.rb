Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :problems
  end

  devise_for :users
  root to: "home#index"
  
end
