Rails.application.routes.draw do

  root 'main#index'

  get 'users/students'
  get 'users/tutors'
  # get 'user/changes'

  get 'users/:id/change(.:format)' =>	'users#changes', as: 'change_user'

  devise_for :users

  resources :users, :except => [:destroy]

  resources :courses do
    resources :course_elements
  end
  resources :groups


  get 'about' => 'main#about'
  get 'contact' => 'main#contact'


end
