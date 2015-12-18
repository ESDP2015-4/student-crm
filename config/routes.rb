Rails.application.routes.draw do

  root 'main#index'

  get 'users/students'
  get 'users/tutors'
  # get 'user/changes'

  get 'users/:id/change(.:format)' => 'users#changes', as: 'change_user'

  devise_for :users

  resources :users, :except => [:destroy]

  resources :courses do
    resources :course_elements
    resources :periods
  end

  resources :groups


  get 'about' => 'main#about'
  get 'contact' => 'main#contact'

  get 'getgoogles/new'
  resources :getgoogles, only: :index
  get "/auth/:provider/callback" => 'getgoogles#create'
  get 'course_elements/new_readings/:id' => 'course_elements#new_readings', as: 'course_elements_new_readings'
  post 'course_elements/create_readings'
  delete 'course_elements/destroy_reading/:id' => 'course_elements#destroy_reading', as: 'course_elements_destroy_reading'

end
