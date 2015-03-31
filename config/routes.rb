Rails.application.routes.draw do

  get 'users/profile'
  get 'users/uploads'
  get 'users/notifications'
  get 'users/read/notifi  cation/:id' => 'users#read_notification'
  get 'users/:id/stats' => 'users#stats'
  post 'users/update'

  get 'sobre'   => 'main#about'
  get 'courses' => 'courses#show'
  get 'courses/json/' => 'courses#subject_levels'
  get 'courses/:course_id/subjects/:subject_id/:level_id' => 'courses#subject_levels'
  get 'rank'    => 'main#rank'
  get  'contato' => 'main#contact'
  post 'contato' => 'main#contact'

  put 'videos/:id/upvote' => 'videos#upvote', as: :upvote_video
  put 'videos/:id/downvote' => 'videos#downvote', as: :downvote_video
  get 'videos/validate' => 'videos#validate'
  get 'videos/:id/start_watch' => 'videos#start_watch'

  put 'questions/:id/upvote' => 'questions#upvote', as: :upvote_question
  put 'questions/:id/downvote' => 'questions#downvote', as: :downvote_question
  get 'exercise/:exercise_id/get_answer/:answer_id' => 'answer#get_answer', as: :get_answer

  get 'topics/show'
  get 'topics' => 'topics#index'
  get 'subjects' => 'subjects#index'

  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: :show
  resources :topics, only: :show
  resources :videos, only: [:index, :new, :create]
  resources :questions, only: [:index, :new, :create]
  resources :resumes
  resources :user_exercise_answers
  resources :users

  mount Ckeditor::Engine => '/ckeditor'

  root 'courses#show'
end
