module PagerAlerts
  class Alert

    def initialize subject
      @subject = subject
    end

    def alert!
      Alerts::IRC.new(subject).notify! if alert_settings.irc
      Alerts::BuildLight.new(subject).disco! if alert_settings.build_light
      Alerts::Audio.new(subject).play! if alert_settings.audio
    end

    private

    attr_reader :subject

    def alert_settings
      @alert_settings ||= Config.settings.alerts
    end
  end
end
