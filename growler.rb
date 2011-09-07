require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'
require 'ruby-growl'

module Utilities
  module Growler
    HOSTNAME = 'localhost'
    APP_NAME = 'ruby'
    ALL_NOTIFIES = ['information', 'warning', 'feed']
    DEFAULT_NOTIFIES = nil
    PASSWORD = 'abc123'
  
    class << self
      attr_accessor :growl
    
      def notify (notification_type, title, message, priority=0, sticky=false)
        get_growl!
        @growl.notify(notification_type, title, message, priority, sticky)
      end
    
      def get_growl!
        @growl ||= Growl.new(HOSTNAME, APP_NAME, ALL_NOTIFIES, DEFAULT_NOTIFIES, PASSWORD)
        abort "Could not create growl instance" if growl.nil?
      end
    end
  end
end