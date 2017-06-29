feature 'make a new user account' do
  scenario ' sign up form' do
    visit('/register')
    fill_in 'email', with: 'joebloggs@bloggs.com'
    fill_in 'password', with: 'password123'
    click_button 'Submit'
    expect(page).to have_content('Welcome joebloggs@bloggs.com')
    expect(User.count).to eq 1
  end
end
