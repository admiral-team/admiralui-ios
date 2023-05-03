# frozen_string_literal: true
require 'base64'
require 'net/http'
require 'net/http/post/multipart'
require_relative '../system/system'

class NexusClient
  attr_accessor :username, :password

  def initialize(base_url:, ssl_verify_mode:)
    @base_url = base_url
    @ssl_verify_mode = ssl_verify_mode
  end

  def upload_maven(
    username:,
    password:,
    repository:,
    group_id:,
    artifact_id:,
    version:,
    generate_pom:,
    packaging:,
    assets:
  )
    uri = URI.parse("#{@base_url}/service/rest/v1/components?repository=#{repository}")
    token = Base64.strict_encode64("#{username}:#{password}")

    body = {}
    body['maven2.groupId'] = group_id unless group_id.nil?
    body['maven2.artifactId'] = artifact_id unless artifact_id.nil?
    body['maven2.version'] = version unless version.nil?
    body['maven2.generate-pom'] = generate_pom unless generate_pom.nil?
    body['maven2.packaging'] = packaging unless packaging.nil?

    (assets || []).each_with_index do |asset, index|
      if asset.is_a?(Hash) && !asset['path'].nil? && !asset['extension'].nil?
        path = asset['path']
        ext = File.extname(path).delete_prefix('.')
        body["maven2.asset#{index + 1}"] = UploadIO.new(File.new(path), ext)
        body["maven2.asset#{index + 1}.extension"] = asset['extension']
      end
    end

    req = Net::HTTP::Post::Multipart.new(uri, body)
    req['Authorization'] = "Basic #{token}"

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
