require 'coveralls'
Coveralls.wear_merged!('rails')
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'webmock/rspec'
WebMock.enable!
# WebMock.disable!
WebMock.allow_net_connect!
include WebMock::API

WebMock::API

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'spec_helper'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include ResponseJSON
  # config.before do
  #   stub_request(
  #     :post,
  #     'https://mss.cpc.getswish.net/swish-cpcapi/api/v1/paymentrequests/'
  #   ).with(
  #     body:
  #       "{\"callbackUrl\":\"https://311f7df2.ngrok.io/swish/callback\",\"payeeAlias\":\"1231181189\",\"payerAlias\":\"1111111111\",\"amount\":54,\"currency\":\"SEK\"}",
  #     headers: {
  #       'Accept' => '*/*',
  #       'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #       'Content-Length' => '139',
  #       'Content-Type' => 'application/json',
  #       'Host' => 'mss.cpc.getswish.net',
  #       'User-Agent' => 'rest-client/2.1.0 (linux-gnu x86_64) ruby/2.6.3p62'
  #     }
  #   ).to_return(
  #     status: 200, body: file_fixture('swish_response.json'), headers: {}
  #   )
  #   stub_request(
  #     :get,
  #     "https://mss.cpc.getswish.net/swish-cpcapi/api/v1/paymentrequests/A750387C14284222BD6F691BB4CE275A"
  #   ).with(
  #     # body:
  #     #   "{\"callbackUrl\":\"https://311f7df2.ngrok.io/swish/callback\",\"payeeAlias\":\"1231181189\",\"payerAlias\":\"1111111111\",\"amount\":54,\"currency\":\"SEK\"}",
  #     headers: {
  #       'Accept' => '*/*',
  #       'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #       'Content-Length' => '139',
  #       'Content-Type' => 'application/json',
  #       'Host' => 'mss.cpc.getswish.net',
  #       'User-Agent' => 'rest-client/2.1.0 (linux-gnu x86_64) ruby/2.6.3p62'
  #     }
  #   ).to_return(
  #     status: 200, body: file_fixture('swish_response.json'), headers: {}
  #   )
  # end
end
FactoryBot::SyntaxRunner.class_eval { include ActionDispatch::TestProcess }
