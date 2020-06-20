# frozen_string_literal: true

require 'net/http'
require 'json'

Handler = Proc.new do |req, res|
  if valid(req)
    from = get_bearings(req.query['from'])
    to = get_bearings(req.query['to'])

    res.status = 200
    res['Content-Type'] = 'text/text; charset=utf-8'
    res.body = calculate_distance(from, to).round.to_s
  else
    bad_request(res)
  end
end

def get_bearings(postcode)
  r = Net::HTTP.get('api.getthedata.com', "/postcode/#{CGI.escape(postcode)}")
  r = JSON.parse(r)
  r = r['data']
  { easting: r['easting'], northing: r['northing'] }
end

def calculate_distance(from, to)
  easting_squared = (from[:easting] - to[:easting]).abs**2
  northing_squared = (from[:northing] - to[:northing]).abs**2
  Math.sqrt(easting_squared + northing_squared)
end

def valid(req)
  req.query['from'] && !req.query['from'].empty? && req.query['to'] && !req.query['to'].empty?
end

def bad_request(res)
  res.status = 400
  res['Content-Type'] = 'text/text; charset=utf-8'
  res.body = "Please provide both a 'from' and a 'to' postcode"
end
