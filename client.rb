# encoding: utf-8

require 'net/http'
require 'uri'

port = ENV['PORT'] || '4567'

print 'Fetching "/"...'
res = Net::HTTP.start('localhost', port) { |h| h.get('/') }
puts (res.code == '200' && res.body == 'welcome') ? "FAIL - I didn't send an API Key!" : "OK"

print 'Fetching "/hello_world"... '
res = Net::HTTP.start('localhost', port) { |h| h.get('/hello_world') }
puts (res.code == '200' && res.body == 'hello world') ? "FAIL - I didn't send an API Key!" : "OK"

print 'Fetching "/"...'
res = Net::HTTP.start('localhost', port) { |h| h.get('/?api_key=awesomeserver') }
puts (res.code == '200' && res.body == 'welcome') ? "OK" : "FAIL - I sent my API key as a param and you didn't let me in! :("

print 'Fetching "/hello_world"... '
res = Net::HTTP.start('localhost', port) do |h|
  h.get('/hello_world', "X-API-Key" => "test:test")
end
puts (res.code == '200' && res.body == 'hello world') ? "OK" : "FAIL - I sent my API key as a header and you didn't let me in! :("

