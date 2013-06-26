module PagerAlerts
  class Alert

    def initialize subject
      @subject = subject
    end

    def alert!
      Alerts::IRC.new(subject).notify!
      Alerts::BuildLight.new(subject).disco!
      Alerts::Audio.new(subject).play!
    end

    private

    attr_reader :subject
  end
end
