module MatchPro
  module Util
    class Config

      # Return a hash of configuration strings
      # @return [Hash] - hash of configuration properties
      @props = {
        # REST endpoints
        :endpoints => {
          :base_url             => 'https://doublethedonation.com/api/360matchpro-partners/v1/',

          # Accounts
          :create_account       => 'create-360-account', # Provision a new account
          :verify_account       => 'verify-360-keys', # Verify an existing account

          # Donations
          :register_donation    => 'register_donation', # Register a donation in the portal
        },

        # Errors to be returned for various exceptions
        :errors => {
          :partner_key_missing => 'Partner Key required.',
          :public_key_missing  => 'Nonprofit Public Key required.',
        }
      }

      class << self
        attr_accessor :props

        def configure
          yield props if block_given?
        end

        # Get a configuration property given a specified location, example usage: Config::get('auth.token_endpoint')
        # @param [String] index - location of the property to obtain
        # @return [String]
        def get(index)
          properties = index.split('.')
          get_value(properties, props)
        end

        private

        # Navigate through a config array looking for a particular index
        # @param [Array] index The index sequence we are navigating down
        # @param [Hash, String] value The portion of the config array to process
        # @return [String]
        def get_value(index, value)
          index = index.is_a?(Array) ? index : [index]
          key = index.shift.to_sym
          value.is_a?(Hash) and value[key] and value[key].is_a?(Hash) ?
          get_value(index, value[key]) :
          value[key]
        end
      end
    end
  end
end
