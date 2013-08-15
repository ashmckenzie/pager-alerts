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

        write_out_state
      end

      private

        def light
          @blinky ||= Blinky.new.light
        end

        def write_out_state
          File.open('/home/dev/bl/last_status', 'w') {|f| f.write('alert') }
        end
    end
  end
end
