# frozen_string_literal: true

Handler = Proc.new do |req, res|
  from = req.query['from']
  to = req.query['to']

  res.status = 200
  res['Content-Type'] = 'text/text; charset=utf-8'
  res.body = '2'
end
