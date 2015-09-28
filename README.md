# Ruby Test: Proxy

## The Problem

We have a Hello World service which serves a very important message to clients
when they hit the /hello_world endpoint. However, we now need to expose this
service to the Internet, and that means ensuring that clients have the correct
API key before they can request it.

The service is extremely simple and we don't want to pollute it with lots of
authentication rubbish. So your job is to write a proxy server that the service
can hide behind, safe in the knowledge that the only requests are authenticated
already.

You need to write a custom HTTP proxy/forwarder which accepts requests from
`client.rb` and checks that either the `X-API-Key` header or `api_key` query
parameter match one of "awesomeserver", "test:test" or "demouser". It should
then strip that header and query param and forward the request to the server.

If the key doesn't match, it should return an appropriate status code.

You are free to use any ruby-based technology within reason to create your
proxy. As long as the client file outputs "FAIL" for the first (unauthenticated)
call and "OK" for the second call, which specifies the `api_key`.

Bonus points for clean code, tests, and asynchronous capabilities.

## Technical

### Setup

To install dependencies for this test with
[bundler](https://rubygems.org/gems/bundler) run:

     bundle install

### Running The Test

#### Server

The server is started with:

    bundle exec ruby server.rb

#### Client

Run the client to see result:

    bundle exec ruby client.rb

By default it tries to connect to port 4567, you can customize the port by
specifying the PORT environment variable.
