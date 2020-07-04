# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/support/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_hosts '127.0.0.1', 'https://worththetrip.vercel.app'
end
