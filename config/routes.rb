Rails.application.routes.draw do
 root to: 'pages#home'
 
 get 'about', to: 'pages#about'
 get 'shedule', to: 'pages#shedule'
 resources :contacts
 
end
