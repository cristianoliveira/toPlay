Rails.application.routes.draw do

  get 'search' => 'search#index'

  get 'users/profile'
  get 'users/uploads'
  get 'users/notifications'
  get 'users/read/notification/:id' => 'users#read_notification'
  get 'users/:id/stats' => 'users#stats'
  post 'users/update'

  get 'sobre' => 'main#about'
  get 'courses' => 'courses#show'
  get 'courses/json/' => 'courses#subject_levels'
  get 'courses/:course_id/subjects/:subject_id/:level_id' => 'courses#subject_levels'
  get 'courses/subject/:id/levels' => 'courses#levels'
  get 'courses/level/:id/topics' => 'courses#topics'
  get 'rank' => 'main#rank'
  get  'contato' => 'main#contact'
  post 'contato' => 'main#contact'

  put 'videos/:id/upvote' => 'videos#upvote', as: :upvote_video
  put 'videos/:id/downvote' => 'videos#downvote', as: :downvote_video
  get 'videos/validate' => 'videos#validate'
  get 'videos/:id/start_watch' => 'videos#start_watch'
  delete 'videos/delete' => 'video#delete'

  put 'questions/:id/upvote' => 'questions#upvote', as: :upvote_question
  put 'questions/:id/downvote' => 'questions#downvote', as: :downvote_question
  get 'exercise/:exercise_id/get_answer/:answer_id' => 'answer#get_answer', as: :get_answer

  get 'topics/show'
  get 'topics' => 'topics#index'
  get 'topics/level' => 'topics#level_topics'

  get 'subjects' => 'subjects#index'
  get 'subject/levels' => 'subjects#levels'

  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: :show
  resources :topics, only: :show
  resources :videos
  resources :questions, only: [:index, :new, :create]
  resources :resumes
  resources :user_exercise_answers
  resources :users
  resources :exercises

  mount Ckeditor::Engine => '/ckeditor'

  root 'courses#show'
end
