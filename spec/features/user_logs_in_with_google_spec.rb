require 'rails_helper'

RSpec.feature 'User logs in' do
  scenario 'using google oauth2' do
    stub_omniauth
    visit root_path
    
    expect(page).to have_link('Sign in with Google')
    
    click_link 'Sign in with Google'

    expect(current_path).to eq(additional_information_path)
    expect(page).to have_content('Identify your role')
    
    select 'designer', :from => 'user_role'
    click_button 'Submit information'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Erika Smith')
    expect(page).to have_link('Logout')
  end

  scenario 'user logs out' do
    stub_omniauth
    visit root_path
    click_link 'Sign in with Google'
    click_link 'Logout'

    expect(page).to have_link('Sign in with Google')
    expect(page).not_to have_content('Erika Smith')
  end
end