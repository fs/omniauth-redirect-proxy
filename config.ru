require "bundler/setup"
require "byebug"
require "uri"
require "base64"

class HelloWorld
  attr_reader :request, :host_with_port

  def call(env)
    @request = Rack::Request.new(env)
    @host_with_port = Base64.decode64(@request.params["state"]).split(":")

    [301, { "Location" => url }, []]
  end

  private

  def new_host
    host_with_port.first
  end

  def new_port
    host_with_port.last
  end

  def url
    URI.parse(request.url).tap do |url|
      url.host = new_host
      url.port = new_port
    end.to_s
  end
end

run HelloWorld.new
