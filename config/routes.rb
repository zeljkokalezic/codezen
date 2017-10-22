Rails.application.routes.draw do

  resources :problems

  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :problems do
      post 'execute'
    end
  end

  devise_for :users

  root to: "problems#index"
  post 'user_token' => 'user_token#create'
  get "problems/:id/solve" => 'problems#solve', :as => :solve_problem
end
