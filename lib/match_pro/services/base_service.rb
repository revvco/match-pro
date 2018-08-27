module Matchpro
  module Services
    class BaseService
      attr_accessor :public_key, :partner_key

      def initialize(public_key, )
        @public_key = public_key
        @partner_key = partner_key
      end

      protected

      def get(path, params = {}, response_type = MatchPro::General)
        url = URI::join(Util::Config.get('endpoints.base_url'), path).to_s
        url = build_url(url, params)
        response = RestClient.get(url, get_headers())
        json_response = JSON.parse(response.body)
        if json_response.is_a?(Array)
          json_response = { data: json_response }
        end
        begin
          response_type.new json_response
        rescue => e
          json_response[:errors] = [e.message]
          MatchPro::Error.new json_response
        end
      end

      def post(path, body = {}, params = {}, response_type = MatchPro::General)
        url = URI::join(Util::Config.get('endpoints.base_url'), path).to_s
        url = build_url(url, params)
        response = RestClient.post(url, body.to_json, get_headers())
        json_response = JSON.parse(response.body)
        if json_response.is_a?(Array)
          json_response = { data: json_response }
        end
        begin
          response_type.new json_response
        rescue => e
          json_response[:errors] = [e.message]
          MatchPro::Error.new json_response
        end
      end

      # Return required headers for making an http request with MatchPro
      # @param [String] content_type - The MIME type of the body of the request, default is 'application/json'
      # @return [Hash] - authorization headers
      def get_headers(content_type = 'application/json')
        {
          :content_type               => content_type,
          :accept                     => 'application/json',
          :user_agent                 => "MatchPro Ruby SDK v#{MatchPro::VERSION} (#{RUBY_DESCRIPTION})",
        }
      end

      # Build a url from the base url and query parameters hash. Query parameters
      # should not be URL encoded because this method will handle that
      # @param [String] url - The base url
      # @param [Hash] params - A hash with query parameters
      # @return [String] - the url with query parameters hash
      def build_url(url, params = nil)
        if params.respond_to? :each
          params.each do |key, value|
            # Convert dates to CC date format
            if value.respond_to? :iso8601
              params[key] = value.iso8601
            end

            if key.to_s == 'next' && value.match(/^.*?next=(.*)$/)
              params[key] = $1
            end
          end
        else
          params ||= {}
        end
        if params == {}
          url
        else
          url + '?' + Util::Helpers.http_build_query(params)
        end
      end

    end
  end
end
