require 'rack/file'

Capybara.app = Rack::File.new File.dirname '.'

describe 'index', type: :feature do
  before { visit 'index.html' }

  it 'contains content' do
    expect(page).to have_content 'Where are you?'
    expect(page).to have_content 'How far will you go?'
    expect(page).to have_content 'Where is the dropoff?'
    expect(page).to have_content "You don't deliver this far!"
    expect(page).to have_content 'Nice, you deliver to this location!'
  end

  describe 'distance form' do
    it 'can be filled out' do
      fill_in 'from', with: 'some text'
      fill_in 'max', with: '2'
      fill_in 'to', with: 'some text'
    end
  end
end
