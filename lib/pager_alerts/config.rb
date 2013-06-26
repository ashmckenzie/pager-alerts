require 'hashie'
require 'singleton'
require 'yaml'

module PagerAlerts
  class Config

    include Singleton

    def self.settings
      instance.settings
    end

    def settings
      @settings ||= Hashie::Mash.new(YAML.load_file(file))
    end

    private

    def file
      File.expand_path(File.join('..', '..', '..', 'config', 'config.yml'), __FILE__)
    end
  end
end
