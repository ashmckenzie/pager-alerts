require 'json'

module PagerAlerts
  class GoogleApi

    attr_reader :oauth2_token

    def initialize
      @oauth2_token = settings.oauth2_token
    end

    def refresh_token!
      response = JSON.parse(RestClient.post(settings.oauth2_url, options))
      @oauth2_token = settings.oauth2_token = response['access_token']
    end

    private

    def settings
      Config.settings.google
    end

    def options
      {
        client_id: settings.client_id,
        client_secret: settings.client_secret,
        refresh_token: settings.oauth2_refresh_token,
        grant_type: 'refresh_token'
      }
    end
  end
end
