Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  get '/admin/users', to: 'administrator#index'
  post '/admin/create_user', to: 'administrator#create_user'
  put '/admin/update_user', to: 'administrator#update'
  delete '/admin/delete_user', to: 'administrator#delete'
  get '/manager/users', to: 'manager#index'
  post '/signup', to: 'users#signup'
  get '/*a', to: 'application#not_found'
end
