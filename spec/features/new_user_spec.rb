require_relative '../web_helper'

feature 'make a new user account' do
  scenario 'sign up form' do
    new_user
    expect(page).to have_content('Welcome joebloggs@bloggs.com')
    expect { new_user }.to change(User, :count).by(1)
  end
end
