require 'spec_helper'
require './proxy'

RSpec.describe 'Proxy' do

  def app
   Sinatra::Application
  end

  def request(url)
    "http://localhost:#{ENV['PORT'] || '4567'}" + url
  end

  describe "request without proper X-API-Key must be ended with status 403" do
    it "have no X-API-Key at all and fail" do
      get request '/'
      expect(last_response.status).to eq(403)
    end
  	it "have wrong api_key and fail" do
      get request "/?api_key=fakeserver"
      expect(last_response.status).to eq(403)
    end
  	it "have wrong X-API-Key http header and fail" do
      get request("/"), nil, {'HTTP_X_API_KEY' => "test:fake:test"}
      expect(last_response.status).to eq(403)
    end
  end
  describe "request with proper X-API-Key must be ended with status 200" do
  	it "have correct X-API-Key http header and fail" do
      get request("/hello_world"), nil, {'HTTP_X_API_KEY' => "demouser"}
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq("hello world")
    end
  	it "have correct api_key and response http ok" do
      get request "/?api_key=awesomeserver"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq("welcome")
    end
  end
end
