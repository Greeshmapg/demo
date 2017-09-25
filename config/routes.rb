Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations",:passwords => "users/passwords"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "teams#index"

  # devise_scope :user do
  #   get "registrations/user_registraion"=> "registrations#user_registraion", :as => "custom_user_registration"
  # end

resources :users

  resources :teams do
    member do
    get "destroy_user", to:"teams#destroy_user", as: "remove_user"
    end
  end
  #get "/teams/index.html.erb", to: "users#display", as: "teamlist"
  get "/addtoteam/:id" ,to:"teams#add_to_team", as:"addtoteam"
  post "/custom_create/:id", to:"users#custom_create", as:"custom_user"
  get "/custom_new/:id", to:"users#custom_new", as:"custom_new"

  get "show_change_password/:id", to:"users#show_change_password", as: "show_change_password"
  patch "custom_change_password/:id", to:"users#custom_change_password", as: "custom_change_password"


 # get "add_existinguser_to_team/:id",to: "teams#add_existinguser_to_team", as:"select_user"



end
