# frozen_string_literal: true

require 'webrick'
require '../api/index'

RSpec.describe Handler do
  context 'with a name' do
    let(:req) do
      r = WEBrick::HTTPRequest.new({})
      r.instance_variable_set(:@query, query)
      r
    end
    let(:query) { { 'name' => 'Alex' } }
    let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: WEBrick::HTTPVersion.new('1.1')) }

    it 'responds with the name' do
      expect(Handler.call(req, res)).to eq(Cowsay.say('Hello Alex', 'cow'))
    end
  end
end
