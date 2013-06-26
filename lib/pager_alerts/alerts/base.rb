module PagerAlerts
  module Alerts
    class Base

      def initialize subject
        @subject = subject
      end

      private

      attr_reader :subject
    end
  end
end
