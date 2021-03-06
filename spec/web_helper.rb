def new_user
  visit '/user/new'
  expect(page.status_code).to eq(200)
  fill_in :email, with: 'joebloggs@bloggs.com'
  fill_in :password, with: 'password123'
  fill_in :confirm_password, with: 'password123'
  click_button 'Submit'
end
