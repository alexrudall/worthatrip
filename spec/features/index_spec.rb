require 'rack/file'
require 'webrick'
require_relative '../../api/v1/handler'

Capybara.app = Rack::File.new File.dirname '.'

describe 'index', type: :feature, js: true do
  before do
    # Easier to hit live than run a local server! 🤷‍♂️
    visit 'https://isitfar.vercel.app/'
    fill_in 'Where are you?', with: from
    fill_in 'How far will you go?', with: distance
    fill_in 'Where is the dropoff?', with: to
    click_on 'Submit'
  end

  describe 'distance form' do
    let(:from) { 'EC3N 4AB' }
    let(:to) { 'M1 1AG' }
    let(:distance) { '1000000' }

    it 'notifies user' do
      expect(page).to have_content 'Nice, you deliver to this location!'
    end

    context 'with a downcased postcode' do
      let(:from) { 'ec3n 4ab' }

      it 'notifies user' do
        expect(page).to have_content 'Nice, you deliver to this location!'
      end
    end

    context 'when too far' do
      let(:distance) { '2' }

      it 'notifies user' do
        expect(page).to have_content "You don't deliver this far!"
      end
    end

    context 'with an invalid origin postcode' do
      let(:from) { '$%^' }

      it 'shows the error' do
        expect(page).to have_content "The 'from' postcode could not be found"
      end
    end

    context 'with an invalid destination postcode' do
      let(:to) { '$%^' }

      it 'shows the error' do
        expect(page).to have_content "The 'to' postcode could not be found"
      end
    end

  end
end
