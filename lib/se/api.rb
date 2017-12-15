require "se/api/version"
require "se/api/types/post"
require "se/api/types/answer"
require "se/api/types/question"

require "net/http"
require "json"
require "uri"
require "time"

module SE
  module API
    class Client
      API_VERSION = 2.2

      attr_reader :quota, :quota_used
      attr_accessor :params

      def initialize(key, **params)
        @key = key
        @params = params.merge({filter: '!*1_).BnZb8pdvWlZpJYNyauMekouxK9-RzUNUrwiB'})
        @quota = nil
        @quota_used = 0
        @backoff = Time.now
        @logger_raw = Logger.new 'api_raw.log'
        @logger_json = Logger.new 'api_json.log'
      end

      def posts(ids = "", **params)
        return if ids == ""
        json("posts/#{Array(ids).join(';')}", **params).map do |i|
          Post.new(i)
        end
      end

      def questions(ids = "", **params)
        return if ids == ""
        json("questions/#{Array(ids).join(';')}", **params).map do |i|
          Question.new(i)
        end
      end

      def answers(ids = "", **params)
        return if ids == ""
        json("answers/#{Array(ids).join(';')}", **params).map do |i|
          Answer.new(i)
        end
      end

      private

      def json(uri, **params)
        throw "No site specified" if params[:site].nil?
        backoff_for = @backoff-Time.now
        backoff_for = 0 if backoff_for <= 0
        if backoff_for > 0
          puts "Backing off for #{backoff_for}"
          sleep backoff_for+2
          puts "Finished backing off!"
        end
        params = @params.merge(params).merge({key: @key}).map { |k,v| "#{k}=#{v}" }.join('&')
        puts "Posting to https://api.stackexchange.com/#{API_VERSION}/#{uri}?#{params}"
        begin
          resp_raw  = Net::HTTP.get_response(URI("https://api.stackexchange.com/#{API_VERSION}/#{uri}?#{params}")).body
        rescue Net::OpenTimeout
          puts "Got timeout on API request. Retrying..."
          retry
        end
        @logger_raw.info "https://api.stackexchange.com/#{API_VERSION}/#{uri}?#{params} => #{resp_raw}"
        resp = JSON.parse(resp_raw)
        @backoff = Time.now + resp["backoff"].to_i
        @logger_json.info "https://api.stackexchange.com/#{API_VERSION}/#{uri}?#{params} => #{resp}"
        @quota = resp["quota_remaining"]
        @quota_used += 1
        resp["items"]
      end
    end
  end
end
