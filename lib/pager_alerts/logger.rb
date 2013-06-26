require 'logger'
require 'singleton'

module PagerAlerts
  class Logger

    include Singleton

    def self.log
      instance.log
    end

    def self.debug *args; log.debug *args end
    def self.info *args; log.info *args end
    def self.warn *args; log.warn *args end
    def self.error *args; log.error *args end

    def log
      @log ||= begin
        logger = ::Logger.new(STDOUT)
        logger.level = ::Logger::INFO
        logger
      end
    end
  end
end
