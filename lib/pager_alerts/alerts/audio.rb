module PagerAlerts
  module Alerts
    class Audio < Base

      def play!
        Thread.new { `mpg123 #{file} 2>&1 /dev/null` }.join
      end

      private

      def file
        File.expand_path('../../../sounds/pager-alert.mp3', __FILE__)
      end
    end
  end
end
