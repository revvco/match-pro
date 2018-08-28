require "match_pro/version"

module MatchPro
  class PartnerApi
    attr_accessor :partner_key

    # Class constructor
    # @param [String]  - Partner key (used for provisioning new accounts)
    # @return
    def initialize(partner_key)
      @partner_key = partner_key 
    end

    # 
    # Account Services
    # 

    def create_account(params)
      Services::AccountService.new(@partner_key).create_account(params)
    end

  end
end
