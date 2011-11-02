#!/bin/ruby
# Author: Corey Osman
# Date: 11/1/11
# Purpose: code to parse msdhcp dump text from dhcp server
# This will get all the dhcp scope information available via the dump file.
require 'lib/scopes'


dumpfile = File.open('dump2.txt', 'r')
@scopes = Scopes.new(dumpfile)
puts @scopes.list

dumpfile.close

