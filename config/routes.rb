Rails.application.routes.draw do

  resources :attendances, only: :index

  patch '/mark', to: 'attendances#mark', as: :mark

  resources :study_units, except: [:destroy, :show]

  root 'main#index'

  patch '/choose_role', to: 'users#set_user_role', as: :choose_role

  get 'users/role_filter/:id' => 'users#role_filter', as: 'users_role_filter'
  get 'users/:id/change(.:format)' => 'users#changes', as: 'change_user'

  devise_for :users

  resources :homeworks
  # post 'homeworks/new' => 'homeworks#create', as: 'post_homeworks'
  # get 'homeworks/download/:id' => 'homeworks#download', as: 'download_homework'
  get 'homeworks/:id/estimate' => 'homeworks#estimate', as: 'estimate_homework'
  get 'homework/:id/replace' => 'homeworks#replace', as: 'replace_homework'
  get 'homework/periods' => 'homeworks#periods', as: 'periods_homework'
  get 'homework/period/:period_id' => 'homeworks#period', as: 'period_homework'

  resources :users, :except => [:destroy]

  resources :courses do
    resources :course_elements
    # resources :periods
  end

  resources :groups do
    #resources :periods
    get 'periods/calendar_group/:group_id' => 'periods#calendar_group', as: 'periods_calendar_group'
    resources :group_memberships
  end

  resources :periods
  get 'selected_groups' => 'periods#selected_groups', as: 'selected_groups'

  get 'about' => 'main#about'
  get 'contact' => 'main#contact'
  get 'getgoogles/new'
  resources :getgoogles, only: :index
  get "/auth/:provider/callback" => 'getgoogles#create'
  get 'course_elements/new_readings/:id' => 'course_elements#new_readings', as: 'course_elements_new_readings'
  post 'course_elements/create_readings'
  delete 'course_elements/destroy_reading/:id' => 'course_elements#destroy_reading', as: 'course_elements_destroy_reading'

end
