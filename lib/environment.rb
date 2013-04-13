# encoding: UTF-8

require 'rubygems'

version = RUBY_VERSION.dup
if Gem::Version.create(version) < Gem::Version.create(1.9)
  puts "Ruby >= 1.9 required to run wpscan (You have #{version})"
  exit(1)
end

begin
  # Standard libs
  require 'bundler/setup'
  require 'getoptlong'
  require 'optparse' # Will replace getoptlong
  require 'uri'
  require 'time'
  require 'resolv'
  require 'xmlrpc/client'
  require 'digest/md5'
  require 'digest/sha1'
  require 'readline'
  require 'base64'
  require 'rbconfig'
  require 'pp'
  # Third party libs
  require 'typhoeus'
  require 'json'
  require 'nokogiri'
  require 'terminal-table'
  # Custom libs
  require 'common/browser'
  require 'common/custom_option_parser'
rescue LoadError => e
  puts "[ERROR] #{e}"

  missing_gem = e.to_s[%r{ -- ([^/]+)/?\z}, 1]
  if missing_gem
    if missing_gem =~ /nokogiri/i
      puts
      puts 'Nokogiri needs some packets, please run \'sudo apt-get install libxml2 libxml2-dev libxslt1-dev\' to install them. Then run the command below'
      puts
    end
    puts "[TIP] Try to run 'gem install #{missing_gem}' or 'gem install --user-install #{missing_gem}'. If you still get an error, Please see README file or https://github.com/wpscanteam/wpscan"
  end
  exit(1)
end

if Typhoeus::VERSION == '0.4.0'
  puts 'Typhoeus 0.4.0 detected, please update the gem otherwise wpscan will not work correctly'
  exit(1)
end
