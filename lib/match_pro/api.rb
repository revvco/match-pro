require "match_pro/version"

module MatchPro
  class Api
    attr_accessor :public_key
    attr_accessor :private_key

    # Class constructor
    # @param [String] public_key - Nonprofit public_key
    # @return
    def initialize(public_key, private_key=nil)
      @public_key = public_key 
      @private_key = private_key 
    end

    #
    # Account Services
    #

    def verify_account
      Services::AccountService.new(@public_key, @private_key).verify_account
    end

    #
    # Donation Services
    #

    def register_donation(params)
      Services::DonationService.new(@public_key).register_donation(params)
    end
  end
end
