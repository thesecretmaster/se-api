require "se/api/version"
require "se/api/types/post"

require "net/http"
require "json"
require "uri"

module SE
  module API
    class Client
      API_VERSION = 2.2

      attr_reader :quota
      attr_accessor :params

      def initialize(key, **params)
        @key = key
        @params = params
        @quota = nil
      end

      def posts(ids = "", **params)
        return if ids == ""
        json("posts/#{Array(ids).join(';')}", **params).map do |i|
          Post.new(i)
        end
      end

      private

      def json(uri, site: nil, **params)
        throw "No site specified" if site.nil?
        params = @params.merge(params).merge({key: @key}).map { |k,v| "#{k}=#{v}" }.join('&')
        resp_raw  = Net::HTTP.get_response(URI("https://api.stackexchange.com/#{API_VERSION}/#{uri}?#{params}")).body
        resp = JSON.parse(resp_raw)
        @quota = resp["quota_remaining"]
        resp["items"]
      end
    end
  end
end
