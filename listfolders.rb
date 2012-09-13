#!/usr/bin/env ruby

if $PROGRAM_FILE == __FILE__
  require 'yaml'
  if ARGV
    require 'open-uri'
    begin
      @config = YAML.load(open ARGV[0])
    rescue
      raise "Cannot open the config file"
    end
  else 
    raise "No config file found"
  end
end

require 'net/imap'

def list_all(srv)
  folders = srv.list("","*")
  folders.each do |f|
    puts "Found: #{f}"
  end
end


## main scripting
src = Net::IMAP.new(@config['source']['host'], 
	@config['source']['port'], 
        @config['source']['ssl'])

src.login(@config['source']['username'], @config['source']['password'])

list_all src

src.close
