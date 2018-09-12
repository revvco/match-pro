module MatchPro
  module Services
    class BaseService
      attr_accessor :public_key, :partner_key

      def initialize(api_key, private_key = nil)
        @api_key = api_key
        @private_key = private_key
      end

      protected

      def get(path, params = {}, response_type = MatchPro::General)

        url = URI::join(Util::Config.get('endpoints.base_url'), path).to_s
        params = add_key(params)
                
        url = build_url(url, params)
        response = RestClient.get(url, get_headers)
        json_response = JSON.parse(response.body)

        begin
          response_type.new json_response
        rescue => e
          json_response[:errors] = [e.message]
          MatchPro::Error.new json_response
        end
      end

      def post(path, body = {}, params = {}, response_type = MatchPro::General)
        url = URI::join(Util::Config.get('endpoints.base_url'), path).to_s
        body = add_key(body)
        response = RestClient.post(url, body.to_json, get_headers)
        json_response = if response.body.present?
          JSON.parse(response.body)
        else
          { response: "No Data"}
        end
        begin
          response_type.new json_response
        rescue => e
          json_response[:errors] = [e.message]
          MatchPro::Error.new json_response
        end
      end

      def get_headers
        {
          content_type: :json,
          accept: :json
        }
      end

      def add_key(params)
        if @api_key
          if @api_key.start_with?("partner")
            params[:partner_api_key] = @api_key
          else
            params["360matchpro_public_key"] = @api_key
          end
        end

        if @private_key
          params["360matchpro_private_key"] = @private_key
        end
        
        params
      end
 
      def build_url(url, params = nil)
        if params == {}
          url
        else
          url + '?' + Util::Helpers.http_build_query(params)
        end
      end

    end

  end
end
