# frozen_string_literal: true

require 'webrick'
require '../api/index'

RSpec.describe Handler do
  context 'with a from and a to postcode' do
    let(:req) do
      r = WEBrick::HTTPRequest.new({})
      r.instance_variable_set(:@query, query)
      r
    end
    let(:query) {
      {
        'from' => 'ABC1',
        'to' => 'DEF2'
      }
    }
    let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: WEBrick::HTTPVersion.new('1.1')) }

    it 'responds with the distance' do
      expect(Handler.call(req, res)).to eq('2')
    end
  end
end
