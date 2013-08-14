module PagerAlerts
  class Alert

    def initialize subject
      @subject = subject
    end

    def alert!
      begin
        Alerts::IRC.new(subject).notify! if alert_settings.irc
      rescue
        # AWWww yeah!
      end

      begin
        Alerts::BuildLight.new(subject).disco! if alert_settings.build_light
      rescue
        # AWWww yeah!
      end

      begin
        Alerts::Audio.new(subject).play! if alert_settings.audio
      rescue
        # AWWww yeah!
      end
    end

    private

    attr_reader :subject

    def alert_settings
      @alert_settings ||= Config.settings.alerts
    end
  end
end
