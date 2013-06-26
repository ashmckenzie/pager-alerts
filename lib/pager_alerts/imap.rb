require 'rest-client'

module PagerAlerts
  class Imap

    def self.create server, user, folder, google_api
      begin
        connect(server, user, folder, google_api)
      rescue Net::IMAP::NoResponseError => e
        if e.message.strip == 'Invalid credentials (Failure)'
          google_api.refresh_token!
          connect(server, user, folder, google_api)
        end
      end
    end

    def self.connect server, user, folder, google_api
      imap = Net::IMAP.new(server, ssl: true, certs: false, verify: false)
      imap.authenticate('XOAUTH2', user, google_api.oauth2_token)
      imap.select(folder)
      imap
    end
  end
end
