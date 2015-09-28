# encoding: utf-8

require 'rubygems'
require 'sinatra'

# Set another port for background server
set :port, ENV['BACKEND_PORT'] || '11139'

get '/' do
  "welcome"
end

get '/hello_world' do
  "hello world"
end
