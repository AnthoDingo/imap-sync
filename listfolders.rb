#!/usr/bin/env ruby

require 'yaml'
if ARGV
  require 'open-uri'
  begin
    puts "Reading config..."
    config = YAML.load(open ARGV[0])
   rescue
     raise "Cannot open the config file"
   end
else 
  raise "No config file found"
end

require 'net/imap'

def list_all(srv)
  folders = srv.list("","*")
  folders.each do |f|
    puts "Found - #{f[:name]}"
  end
end


## main scripting
src = Net::IMAP.new(config['source']['host'], 
	config['source']['port'], 
        config['source']['ssl'])

src.login(config['source']['username'], config['source']['password'])

dst = Net::IMAP.new(config['destination']['host'],
        config['destination']['port'],
        config['destination']['ssl'])

dst.login(config['destination']['username'], config['destination']['password'])

list_all src

puts "Folders at dst:"
list_all dst
