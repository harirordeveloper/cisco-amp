require 'rest-client'
require 'base64'

module CiscoAmpApi
  module V1
    class Client
      API_ENDPOINT = 'https://api.amp.cisco.com/v1'.freeze

      attr_reader :oauth_token

      def initialize(api_client, api_key)
        @oauth_token = encoded_token(api_client, api_key)
      end

      def computers
        request(
          http_method: :get,
          endpoint: API_ENDPOINT + "/computers"
        )
      end

      def computer_activity

      end

      def computer_vulnarabilities connector_guid
        request(
          http_method: :get,
          endpoint: API_ENDPOINT + "/computers/#{connector_guid}/vulnerabilities"
        )
      end

      def user_trajectory connector_guid
        request(
          http_method: :get,
          endpoint: API_ENDPOINT + "/computers/#{connector_guid}/user_trajectory"
        )
      end

      private

      def encoded_token api_client, api_key
        "Basic " + Base64.strict_encode64("#{api_client}:#{api_key}")
      end

      def request(http_method:, endpoint:, params: {})
        response = RestClient::Request.execute(url: endpoint, method: http_method, params: params, headers:{ Authorization: @oauth_token} )
        JSON.parse(response.body).with_indifferent_access
      end
    end
  end
end
