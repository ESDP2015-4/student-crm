Rails.application.routes.draw do

  resources :attendances, only: :index

  patch '/check', to: 'attendances#check', as: :check

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

  resources :courses, :except => [:destroy] do
    resources :course_elements, :except => [:destroy]
    get 'classmates' => 'courses#classmates', as: 'classmates'
    resources :groups, except: [:destroy] do

      get 'periods/calendar_group/:group_id' => 'periods#calendar_group', as: 'periods_calendar_group'

      resources :group_memberships, only: [:new, :create]

      resources :attendances, only: :index
    end
  end

  get '/change_tab/:group_id/:group_tab_id' => 'groups#change_tab', as: 'change_group_tab'


  resources :periods, except: [:destroy]
  get 'selected_groups' => 'periods#selected_groups', as: 'selected_groups'
  get 'schedule_table' => 'periods#schedule_table', as: 'schedule_table'

  get 'about' => 'main#about'
  get 'contact' => 'main#contact'
  get 'getgoogles/new'
  resources :getgoogles, only: :index
  get "/auth/:provider/callback" => 'getgoogles#create'
  get 'course_elements/new_readings/:id' => 'course_elements#new_readings', as: 'course_elements_new_readings'
  post 'course_elements/create_readings'
  delete 'course_elements/destroy_reading/:id' => 'course_elements#destroy_reading', as: 'course_elements_destroy_reading'

end
