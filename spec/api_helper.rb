# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = %i[html slate]

  config.filter = :all

  # The test are displayed in the documentation in the same order that in the test files
  config.keep_source_order = true

  # Used when adding a cURL output to the docs
  config.curl_host = 'http://localhost:3000'
  config.curl_headers_to_filter = %w[Host Cookie]

  config.request_headers_to_include = ['Content-Type']
  config.response_headers_to_include = ['Content-Type']

  # Change the name of the API on index pages
  config.api_name = 'Top Score Ranking - API Documentation'
  config.request_body_formatter = proc do |body|
    JSON.pretty_generate(body)
  end

  # Makes the generated json response easier to read
  config.response_body_formatter = proc do |_ct, response_body|
    JSON.pretty_generate(JSON.parse(response_body))
  end
end

# monkey patch for issue: https://github.com/zipmark/rspec_api_documentation/issues/456
module RspecApiDocumentation
  class RackTestClient < ClientBase
    def response_body
      last_response.body.encode('utf-8')
    end
  end
end
