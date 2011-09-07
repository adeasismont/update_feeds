#!/usr/bin/ruby
require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'
require 'yaml'
require './rss'
require './growler'

module Utilities
  class Feedr
    CONFIG_FILE = ENV['HOME'] + '/.utilities/feedr'
    RECENTS_FILE = ENV['HOME'] + '/.utilities/feedr-recents'
    
    attr_reader :feeds, :recents
    
    def initialize
      read_configuration!
      read_recents!
    end
    
    def run!
      @feeds.each do |name, url|
        latest_post = RSS.latest_post(url)
        if !@recents[url].eql?(latest_post[:guid])
          @recents[url] = latest_post[:guid]
          Growler.notify('feed', name, "#{latest_post[:title]}\n\n#{latest_post[:description]}")
        end
      end
      write_recents!
    end
    
    private
    def read_configuration!
      configuration = YAML.load(File.read(CONFIG_FILE)) if File.exist?(CONFIG_FILE)
      @feeds = configuration || {}
    end
    
    def read_recents!
      configuration = YAML.load(File.read(RECENTS_FILE)) if File.exist?(RECENTS_FILE)
      @recents = configuration || {}
    end
    
    def write_recents!
      File.open(RECENTS_FILE, 'w') do |f|
        f.write(YAML.dump(@recents))
      end
    end
  end
end

feedr = Utilities::Feedr.new
feedr.run!