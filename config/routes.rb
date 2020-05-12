Rails.application.routes.draw do
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
end
