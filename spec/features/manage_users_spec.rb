feature 'user login' do
  scenario 'matching password confirmation' do
    expect { sign_up(confirm_password: 'wrong') }.not_to change(User, :count)
  end

    def sign_up(email: 'joebloggs@bloggs.com', password: 'password123', confirm_password: 'password123')
      visit '/user/login'
      fill_in :email, with: email
      fill_in :password, with: password
      fill_in :confirm_password, with: confirm_password
      click_button 'Submit'
    end
end
