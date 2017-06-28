# spec/features/viewing_links_spec.rb
feature 'Viewing links' do
  scenario 'see a list of exisitng links on the homepage' do
    Link.create(url: 'http://www.google.com', title: 'Google')
    visit('/links')
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
  
  before(:each) do
    Link.create(url: 'http://www.bbc.co.uk', title: 'BBC', tags: [Tag.first_or_create(name: 'News')])
    Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'Browser')])
    Link.create(url: 'http://www.bubbleology.com', title: 'Bubbleology', tags: [Tag.first_or_create(name: 'bubbles')])
  end

  scenario 'filter website links by tags' do
    visit('/tags/bubbles')
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).not_to have_content('BBC')
      expect(page).not_to have_content('Google')
      expect(page).to have_content('Bubbleology')
    end
  end
end
