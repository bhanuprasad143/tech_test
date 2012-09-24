CurrencyCollection::Application.routes.draw do
  
  get 'home/index'
  devise_for :users
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
  end
  
  match 'user/update_visit' => 'users#update_visit', :as => 'user_update_visit' 
  match 'home/sort_country' => 'home#sort_country', :as => 'sort_country'

  root :to => 'home#index'

end
