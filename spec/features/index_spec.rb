require 'rack/file'

Capybara.app = Rack::File.new File.dirname '.'

describe 'index', type: :feature do
  it 'contains content' do
    visit 'index.html'
    expect(page).to have_content 'Where are you?'
    expect(page).to have_content 'How far will you go?'
    expect(page).to have_content 'Where is the requested dropoff?'
    expect(page).to have_content "You don't deliver this far!"
    expect(page).to have_content 'Nice, you deliver to this address!'
  end
end
