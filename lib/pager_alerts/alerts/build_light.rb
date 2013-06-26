require 'blinky'

module PagerAlerts
  module Alerts
    class BuildLight < Base

      def disco!
        10.times do
          light.building!
          sleep 0.5
          light.failure!
          sleep 0.5
        end

        # Can't get previous state ?
        #
        light.warning!
      end

      private

      def light
        @blinky ||= Blinky.new.light
      end
    end
  end
end
