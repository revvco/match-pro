module MatchPro
  module Util
    class Helpers
      class << self

        # Build the HTTP query from the given parameters
        # @param [Hash] params
        # @return [String] query string
        def http_build_query(params)
          params.collect{ |k,v| "#{k}=#{encode(v)}" }.reverse.join('&')
        end

        # Escape special characters
        # @param [String] str
        def encode(str)
          CGI.escape(str).gsub('.', '%2E').gsub('-', '%2D')
        end

        # String to bool
        # @param [String] str
        def to_bool(str)
          return true if str == true || str =~ (/(true|t|yes|y|1)$/i)
          return false if str == false || str == nil || str == '' || str =~ (/(false|f|no|n|0)$/i)
        end

        # String to DateTime
        # @param [String] str
        def to_date_time(str)
          begin 
            Time.parse(str)
          rescue
            str
          end
        end
      end
    end
  end
end
