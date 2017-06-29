# spec/features/adding_tags_spec.rb
feature 'Adding tags' do
  scenario 'Add a single tag for a new website link' do
    visit('/links/new')
    fill_in 'url', with: 'http://www.google.com'
    fill_in 'title', with: 'Google'
    fill_in 'tags', with: 'Browsers'
    click_button('Add link')
    link = Link.first
    expect(link.tags.map(&:name)).to include('Browsers')
  end
end

feature 'Multiple tags' do
  scenario 'add multiple tags to one link' do
    visit('/links/new')
    fill_in 'url', with: 'http://www.google.com'
    fill_in 'title', with: 'Google'
    fill_in 'tags', with: 'Browsers, Search'
    click_button('Add link')
    link = Link.first
    expect(link.tags.map(&:name)).to include('Browsers').and include('Search')
  end
end
