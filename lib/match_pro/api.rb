require "match_pro/version"

module MatchPro
  class Api
    attr_accessor :public_key, :partner_key

    # Class constructor
    # @param [String] public_key - Nonprofit public_key
    # @param [String]  - Partner key (used for provisioning new accounts)
    # @return
    def initialize(public_key, partner_key)
      @public_key = public_key 
      @partner_key = partner_key 
    end

    # 
    # Account Services
    # 

    def create_account(params)
      Services::AccountService.new(partner_key).create_contact(params)
    end

    def verify_account
      Services::AccountService.new(public_key).verify_account
    end

    #
    # Donation Services
    #

    def register_donation(params)
      Services::DoantionService.new(public_key).register_donation(params)
    end
  end
end
