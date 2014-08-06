Rails.application.routes.draw do
  get 'user/index'
  post '/get_questions.json', to: 'user#get_questions'

  root :to => 'user#index'
end
