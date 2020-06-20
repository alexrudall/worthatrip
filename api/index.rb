# frozen_string_literal: true

require 'net/http'
require 'json'

Handler = proc do |req, res|
  if valid(req)
    from = get_bearings(req.query['from'])
    to = get_bearings(req.query['to'])

    if from.nil?
      respond(res, 404, "The 'from' postcode could not be found")
    elsif to.nil?
      respond(res, 404, "The 'to' postcode could not be found")
    else
      distance = calculate_distance(from, to).round.to_s
      respond(res, 200, distance)
    end
  else
    respond(res, 400, "Please provide both a 'from' and a 'to' postcode")
  end
end

def get_bearings(postcode)
  r = Net::HTTP.get('api.getthedata.com', "/postcode/#{CGI.escape(postcode)}")
  r = JSON.parse(r)
  r = r['data']

  { easting: r['easting'], northing: r['northing'] } if r && r['easting']
end

def calculate_distance(from, to)
  easting_squared = (from[:easting] - to[:easting]).abs**2
  northing_squared = (from[:northing] - to[:northing]).abs**2
  Math.sqrt(easting_squared + northing_squared)
end

def valid(req)
  req.query['from'] && !req.query['from'].empty? && req.query['to'] && !req.query['to'].empty?
end

def respond(res, status, body)
  res.status = status
  res.body = body
  res['Content-Type'] = 'text/text; charset=utf-8'
end
