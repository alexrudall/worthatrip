require 'rack/file'

Capybara.app = Rack::File.new File.dirname '.'

describe 'index', type: :feature do
  before { visit 'index.html' }

  describe 'distance form' do
    let(:from) { 'EC3N 4AB' }
    let(:to) { 'M1 1AG' }

    context 'when too far' do
      it 'notifies user' do
        fill_in 'Where are you?', with: from
        fill_in 'How far will you go?', with: '2'
        fill_in 'Where is the dropoff?', with: to
        expect(page).to have_content "You don't deliver this far!"
      end
    end

    context 'when within range' do
      it 'notifies user' do
        fill_in 'Where are you?', with: 'some text'
        fill_in 'How far will you go?', with: '2000'
        fill_in 'Where is the dropoff?', with: 'some text'
        expect(page).to have_content 'Nice, you deliver to this location!'
      end
    end
  end
end
