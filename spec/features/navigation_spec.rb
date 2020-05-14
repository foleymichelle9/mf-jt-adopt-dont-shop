require 'rails_helper'

RSpec.describe 'Navigation bar' do
  it 'has a total count of all pets that I have favorited' do

    visit '/pets'

    within 'nav' do
      expect(page).to have_content("Number of pets favorited: 0")
    end
  end
  
  it 'has a total count of all pets that I have favorited' do

    visit '/shelters'

    within 'nav' do
      expect(page).to have_content("Number of pets favorited: 0")
    end
  end
end
# As a visitor
# I see a favorite indicator in my navigation bar
# The favorite indicator shows a count of pets in my favorites list
# I can see this favorite indicator from any page in the application
