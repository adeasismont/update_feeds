require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'
require 'simple-rss'
require 'sanitize'
require 'htmlentities'
require 'open-uri'
require './additions.rb'

module Utilities
  module RSS
    class << self
      attr_reader :coder
    
      def latest_post (url)
        feed = open(url)
        rss = SimpleRSS.parse(feed)
        item = rss.items.first
        returning Hash.new do |post|
          post[:title] = item.title
          post[:guid] = item.guid
          post[:description] = Sanitize.clean(self.coder.decode(item.description)).shorten(100)
        end
      end
      
      def coder
        return (@coder ||= HTMLEntities.new)
      end
    end
  end
end