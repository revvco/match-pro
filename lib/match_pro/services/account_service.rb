module MatchPro
  module Services

    class AccountService < BaseService
   
      def create_account(account_params)
        post(Util::Config.get('endpoints.create_account'), account_params, {})
      end

      def verify_account
        get(Util::Config.get('endpoints.verify_account'), nil)
      end
    end

  end
end
