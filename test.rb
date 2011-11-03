#!/bin/ruby
# Author: Corey Osman
# Date: 11/1/11
# Purpose: code to parse msdhcp dump text from dhcp server
# This will get all the dhcp scope information available via the dump file.
# This file is a sample program that uses the msdhcpdump gem to parse a dump file into objects

require 'rubygems'
require 'msdhcpdump'


dumpfile = File.open('sampledump.txt', 'r')
@dhcpdump = Msdhcpdump.new(dumpfile)

# List the all the dhcp scopes found in the dump
puts "\nAll scopes in dump file"
puts @dhcpdump.list

# Show the properties of a specific scope
puts "\nShow the properties of scope"
puts @dhcpdump["192.168.19.0"].to_s
# Show the exclusions
puts "\nShow the Exclusions \n"
puts @dhcpdump["192.168.19.0"].exclusions

# Show the reservations of the scope
puts "\nScope Reservations\n"
puts @dhcpdump["192.168.19.0"].reservations

# Show Active Scopes
puts "\nAll Active Scopes"
@dhcpdump.each_value do |sc|
   puts "#{sc.net}" if sc.active?
end

# Show All Scope properties
puts "\n"
@dhcpdump.each_value do |sc|
   puts sc.to_s
end
dumpfile.close
