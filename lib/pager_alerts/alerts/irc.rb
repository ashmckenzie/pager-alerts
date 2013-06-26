require 'rest-client'

module PagerAlerts
  module Alerts
    class IRC < Base

      def notify!
        RestClient.post url, payload
      end

      private

      def settings
        Config.settings.irc
      end

      def payload
        { message: message }
      end

      def message
        sprintf(settings.message_format, subject)
      end

      def url
        sprintf(settings.hoobot_url, settings.channel)
      end
    end
  end
end
