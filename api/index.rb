# frozen_string_literal: true
require 'net/http'
require 'json'

Handler = Proc.new do |req, res|
  from = get_bearings(req.query['from'])
  to = get_bearings(req.query['to'])

  res.status = 200
  res['Content-Type'] = 'text/text; charset=utf-8'
  res.body = '2'
end

def get_bearings(postcode)
  r = Net::HTTP.get('api.getthedata.com', "/postcode/#{CGI.escape(postcode)}")
  r = JSON.parse(r)
  r = r['data']
  [r['easting'], r['northing']]
end
