# encoding: utf-8
require 'rubygems'
require 'sinatra'

# We need to set primary port for proxy, 'cause it have to catch all request to front of application
set :port, ENV['PORT'] || '4567'

ACCEPTABLE_PARAMS = %w(awesomeserver test:test demouser)

get '/*' do
  if ACCEPTABLE_PARAMS.include? request.env["HTTP_X_API_KEY"] or ACCEPTABLE_PARAMS.include? request.params['api_key']
    server_response = proxy_request(request)
    status server_response.code
    server_response.body
  else
    halt 403
  end
end

private

def proxy_request(request)
  #strip api_key params and headers
  request.params.delete('api_key') if request.params['api_key']
  uri = URI.parse(request.url)
  uri.query = URI.encode_www_form(request.params)
  uri.port = ENV['BACKEND_PORT'] || '11139'
  Net::HTTP.get_response(uri)
end
