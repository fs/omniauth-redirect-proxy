# frozen_string_literal: true

require "bundler/setup"
require "uri"
require "base64"

class RedirectProxy
  attr_reader :request, :base_url

  def call(env)
    @request = Rack::Request.new(env)
    @base_url = URI.parse(Base64.decode64(@request.params["state"]))

    [301, { "Location" => url }, []]
  end

  private

  def url
    URI.parse(request.url).tap do |url|
      url.scheme = base_url.scheme
      url.host = base_url.host
      url.port = base_url.port
    end.to_s
  end
end

run RedirectProxy.new
