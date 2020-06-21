require 'rack/file'

Capybara.app = Rack::File.new File.dirname __FILE__

describe 'index', type: :feature do
  it 'contains Hello World!' do
    visit 'index.html'
    expect(page).to have_content 'Hello world!'
  end
end
