# frozen_string_literal: true

require 'webrick'
require '../api/index'

RSpec.describe Handler do
  describe 'GET request' do
    let(:req) do
      r = WEBrick::HTTPRequest.new({})
      r.instance_variable_set(:@query, query)
      r
    end
    let(:query) {
      {
        'from' => from,
        'to' => to
      }
    }
    let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: WEBrick::HTTPVersion.new('1.1')) }
    let(:from) { 'EC3N 4AB' }
    let(:to) { 'M1 1AG' }

    it 'responds with the distance' do
      # Sense checked with https://ukpostcodes.tenfourzero.net/?from=ec3n4ab&to=m11ag
      # which gives 263950, accurate to within 10 metres.
      expect(Handler.call(req, res)).to eq('263947')
    end

    context 'missing a postcode' do
      let(:from) { '' }

      it 'responds with an error' do
        expect(Handler.call(req, res)).to eq("Please provide both a 'from' and a 'to' postcode")
      end
    end

    context 'with an invalid postcode' do
      let(:to) { 'M1' }

      it 'responds with an error' do

      end
    end

    context 'with a downcased postcode' do
      it 'responds with the distance' do

      end
    end

  end
end
