require 'net/imap'
require 'gmail_xoauth'

module PagerAlerts
  class Check

    def process
      Net::IMAP.debug = settings.debug

      begin
        imap_connection.idle do |resp|
          if resp.kind_of?(Net::IMAP::UntaggedResponse) and resp.name == "EXISTS"
            process_envelope(resp.data)
          end
          Logger.info 'Idle..'
        end
      rescue Net::IMAP::Error => e
        # Re-connect
        self.new.process
      end
    end

    private

    def alert_settings
      @alert_settings ||= Config.settings.alerts
    end

    def settings
      @settings ||= Config.settings.imap
    end

    def google_api
      @google_api = GoogleApi.new
    end

    def process_envelope message_id
      new_imap_connection do |connection|
        connection.fetch(message_id, 'ENVELOPE').each do |envelope|
          subject = envelope.attr['ENVELOPE'].subject
          Logger.info "Alert: #{subject}"
          Alert.new(subject).alert! if alert_settings.enabled
        end
      end
    end

    def imap_connection
      @imap_connection = new_imap_connection
    end

    def new_imap_connection
      connection = Imap.create(settings.server, settings.user, settings.folder, google_api)

      if block_given?
        yield connection
        connection.logout
      else
        connection
      end
    end
  end
end
