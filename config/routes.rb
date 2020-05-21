Rails.application.routes.draw do
  root 'shelters#index'
  get '/', to: 'shelters#index'

  #shelters
  get '/shelters/new', to: 'shelters#new'
  get '/shelters', to: 'shelters#index'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  #pets
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  patch '/pets/:id/adoptable', to: 'pets#adoptable'
  patch '/pets/:id/pending', to: 'pets#pending'
  delete '/pets/:id', to: 'pets#destroy'

  #shelter_pets
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:shelter_id/pets', to: 'shelter_pets#create'
  delete '/shelters/:shelter_id/pets/:pet_id', to: 'shelter_pets#destroy'

  #shelter_reviews
  get '/shelters/:shelter_id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'shelter_reviews#create'

  get '/reviews/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/reviews/:review_id', to: 'shelter_reviews#update'
  delete '/reviews/:review_id', to: 'shelter_reviews#destroy'

  #favorites
  get '/favorites', to: 'favorites#index'
  delete 'favorites', to: 'favorites#destroy'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites/:pet_id', to: 'favorites#remove_one'

  #applications
  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'
  get '/applications/:id', to: 'applications#show'

  #pet_applications
  get '/pets/:pet_id/applications', to: 'pet_applications#index'
  patch '/pets/:pet_id/applications/:id', to: 'pet_applications#update'
end
