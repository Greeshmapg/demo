Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations",:passwords => "users/passwords"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "teams#index"

  # devise_scope :user do
  #   get "registrations/user_registraion"=> "registrations#user_registraion", :as => "custom_user_registration"
  # end

  resources :users do
    member do
      post "custom_create", as:"custom_user"
      get "custom_new"
      get "show_change_password"
      patch "custom_change_password"
      get "view_edit_profile"
      patch "edit_user_profile", to: "users#edit_profile"
    end
  end

  resources :tasks do
    member do
      get "task_action"
      patch "task_complete"
      patch "task_start"
      post "assign_task", to: "tasks#create"
    end
  end

  resources :teams do
    member do
    get "destroy_user", as: "remove_user"
    get "add_to_team"
    get "show_delete_modal"
    end
  end

end
