require_relative '../web_helper'

feature 'make a new user account' do
  scenario 'sign up form' do
    new_user
    expect(page).to have_content('Welcome joebloggs@bloggs.com')
    expect { new_user }.to change(User, :count).by(1)
  end
end

feature 'user login' do
  scenario 'matching password confirmation' do
    expect { sign_up(confirm_password: 'wrong') }.not_to change(User, :count)
  end

    def sign_up(email: 'joebloggs@bloggs.com', password: 'password123', confirm_password: 'password123')
      visit '/user/new'
      fill_in :email, with: email
      fill_in :password, with: password
      fill_in :confirm_password, with: confirm_password
      click_button 'Submit'
    end
end
