# frozen_string_literal: true

require 'net/http'
require 'json'

class Handler < WEBrick::HTTPServlet::AbstractServlet
  def do_GET request, response
    if valid?(request)
      from = get_bearings(request.query['from'])
      to = get_bearings(request.query['to'])

      if from.nil?
        respond(response, 404, "The 'from' postcode could not be found")
      elsif to.nil?
        respond(response, 404, "The 'to' postcode could not be found")
      else
        distance = calculate_distance(from, to).round.to_s
        respond(response, 200, distance)
      end
    else
      respond(response, 400, "Please provide both a 'from' and a 'to' postcode")
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

  def valid?(request)
    request.query['from'] && !request.query['from'].empty? && request.query['to'] && !request.query['to'].empty?
  end

  def respond(response, status, body)
    response.status = status
    response.body = body
    response['Content-Type'] = 'text/text; charset=utf-8'
  end

end
