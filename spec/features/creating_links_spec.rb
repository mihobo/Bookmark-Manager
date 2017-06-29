# spec/features/creating_links_spec.rb
feature 'Save a website' do
  scenario 'add a site\'s website address and title to my bookmark manager' do
    visit('/links/new')
    fill_in 'url', with: 'http://www.google.com'
    fill_in 'title', with: 'Google'
    fill_in 'tags', with: 'Browsers'
    click_button('Add link')
    expect(current_path).to eq('/links')

    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
end
