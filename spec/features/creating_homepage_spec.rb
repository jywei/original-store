require "rails_helper"

  RSpec.feature "Creating Homepage" do

    scenario do
      visit '/'

      expect(page).to have_link('Craving')
      expect(page).to have_content('Searching into authentic experiences?')
    end
end
