class Application < ApplicationRecord

validates_presence_of :name,
                      :address,
                      :city,
                      :state,
                      :zip,
                      :phone,
                      :description

has_many :application_pets
has_many :pets, through: :application_pets

end
