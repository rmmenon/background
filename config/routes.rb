Background::Application.routes.draw do
  resources :users
  match 'users/:id/email' => 'users#email', :as => :email_user

  mount Resque::Server, :at => '/resque'
end
