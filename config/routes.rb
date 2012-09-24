TechTest::Application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
  end
  
  get 'home/index'
  root :to => 'home#index'

end
