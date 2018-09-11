module MatchPro
  module Services

    class DonationService < BaseService
   
      def register_donation(donation_params)
        post(Util::Config.get('endpoints.register_donation'), donation_params, {})
      end
      
    end

  end
end
