#!/bin/ruby
# Author: Corey Osman
# Date: 11/1/11
# Purpose: code to parse msdhcp dump text from dhcp server
# This will get all the dhcp scope information available via the dump file.
require 'rubygems'
require 'msdhcpdump'


dumpfile = File.open('sampledump.txt', 'r')
@dhcpdump = Msdhcpdump.new(dumpfile)
puts @dhcpdump.list
@dhcpdump.each_value do |s|
        puts s.getleases
        puts "\n"
        puts s.exclusions
#        puts s.to_s

end

dumpfile.close
