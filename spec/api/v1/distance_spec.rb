# frozen_string_literal: true

require 'webrick'
require '../api/v1/distance'

RSpec.describe Handler do
  describe 'GET request' do
    let(:request) do
      r = WEBrick::HTTPRequest.new({})
      r.instance_variable_set(:@query, query)
      r
    end
    let(:query) do
      {
        'from' => from,
        'to' => to
      }
    end
    let(:response) { WEBrick::HTTPResponse.new(HTTPVersion: WEBrick::HTTPVersion.new('1.1')) }
    let(:from) { 'EC3N 4AB' }
    let(:to) { 'M1 1AG' }

    before { Handler.call(request, response) }

    it 'responds with the distance' do
      # Sense checked with https://ukpostcodes.tenfourzero.net/?from=ec3n4ab&to=m11ag
      # which gives 263950, accurate to within 10 metresponse.
      expect(response.status).to eq(200)
      expect(response.body).to eq('263947')
    end

    context 'missing a postcode' do
      let(:from) { '' }

      it 'responds with a 400 error' do
        expect(response.status).to eq(400)
        expect(response.body).to eq("Please provide both a 'from' and a 'to' postcode")
      end
    end

    context 'with an invalid origin postcode' do
      let(:from) { '$%^' }

      it 'responds with a 404 error' do
        expect(response.status).to eq(404)
        expect(response.body).to eq("The 'from' postcode could not be found")
      end
    end

    context 'with an invalid destination postcode' do
      let(:to) { '%^&' }

      it 'responds with a 404 error' do
        expect(response.status).to eq(404)
        expect(response.body).to eq("The 'to' postcode could not be found")
      end
    end

    context 'with a downcased postcode' do
      let(:from) { 'ec3n 4ab' }

      it 'responds with the distance' do
        expect(response.status).to eq(200)
        expect(response.body).to eq('263947')
      end
    end
  end
end
