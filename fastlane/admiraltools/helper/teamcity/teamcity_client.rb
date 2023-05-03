require 'uri'
require 'base64'
require 'json'
require 'net/http'

class TeamCityClient
  CONTENT_TYPE_HEADER_NAME = 'Content-Type'.freeze
  CONTENT_TYPE_HEADER_VALUE = 'application/json'.freeze
  AUTHORIZATION_HEADER_NAME = 'Authorization'.freeze

  def initialize(base_url:, ssl_verify_mode:)
    @base_url = base_url
    @ssl_verify_mode = ssl_verify_mode
  end

  def trigger(username:, user_password:, branch_name:, build_id:)
    uri = URI.parse("#{@base_url}/app/rest/buildQueue")
    params = { 'buildTypeId': build_id, 'branchName': branch_name }
    token = Base64.strict_encode64("#{username}:#{user_password}")

    req = Net::HTTP::Post.new(uri.request_uri.to_s)
    req[CONTENT_TYPE_HEADER_NAME] = CONTENT_TYPE_HEADER_VALUE
    req[AUTHORIZATION_HEADER_NAME] = "Basic #{token}"
    req.body = params.to_json

    http = create_http_client(uri)

    res = http.start do |h|
      h.request(req)
    end

    raise "HTTP Status Code: #{res.code}\n#{res.body}" unless res.is_a?(Net::HTTPSuccess)
  end

  def create_http_client(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = @ssl_verify_mode || OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    http
  end
end