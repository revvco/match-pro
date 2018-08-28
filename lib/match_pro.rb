require "match_pro/version"
require 'rubygems'
require 'rest_client'
require 'json'
require 'hashie'
require 'openssl'
require 'base64'

module MatchPro
  autoload :Api, 'match_pro/api'
  autoload :PartnerApi, 'match_pro/partner_api'

  autoload :VERSION, 'match_pro/version'

  # Models
  autoload :Base, 'match_pro/models/base'
  autoload :Account, 'match_pro/models/account'
  autoload :Donation, 'match_pro/models/donation'
  autoload :General, 'match_pro/models/general'

  module Requests
  end

  module Responses
  end

  module Services
    autoload :BaseService, 'match_pro/services/base_service'
    autoload :AccountService, 'match_pro/services/account_service'
    autoload :DonationService, 'match_pro/services/donation_service'
  end

  module Exceptions
    autoload :ServiceException, 'match_pro/exceptions/service_exception'
  end

  module Util
    autoload :Config, 'match_pro/util/config'
    autoload :Helpers, 'match_pro/util/helpers'
  end
end
