Rails.application.routes.draw do

  put 'videos/:id/upvote' => 'videos#upvote', as: :upvote_video
  put 'videos/:id/downvote' => 'videos#downvote', as: :downvote_video
  put 'questions/:id/upvote' => 'questions#upvote', as: :upvote_question
  put 'questions/:id/downvote' => 'questions#downvote', as: :downvote_question
  get 'exercise/:exercise_id/get_answer/:answer_id' => 'answer#get_answer', as: :get_answer

  get 'topics/show'

  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: :show
  resources :topics, only: :show
  resources :videos, only: [:index, :new, :create]
  resources :questions, only: [:index, :new, :create]

  root 'courses#show' #, id: Course.first.id
end
