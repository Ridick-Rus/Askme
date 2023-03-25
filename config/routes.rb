Rails.application.routes.draw do
  root to: "questions#index"

  resources :questions do
    member do
      put 'hide'
    end
  end

  resource :session, only: %i[new create destroy]
  resources :users, param: :nickname, except: %i[index]
  resources :hash_tags, param: :text, only: %i[show]
end
