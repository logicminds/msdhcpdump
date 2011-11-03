require 'lib/lease'
require 'lib/scope'
require 'lib/exclusion'


class Msdhcpdump < Hash
  def initialize(dhcpdump)
    super()
    @debug=false
    processdump(dhcpdump)
  end
  def add(matchobj)
   newscope = Scope.new(matchobj)
   self[newscope.net] = newscope
  end

  def list
    self.keys
  end
  
  def getscopes
     self.values
  end
 # def active
 #   activelist = Array.new
 #   self.each_value do
 #     puts sc.name
 #     if sc.active?
 #        activelist << sc 
 #     end
 #   end
 #   return activelist
 # end
  private 
  def processdump(dhcpdump)
     linenumber=0
     dhcpdump.each {|line|
      linenumber+=1
      # Ignore all comments that start with "#"
      next if line.match(/^\#/)
      # Ignore all scope set optionvalue
      next if line.match(/.+Scope.+\ set\ optionvalue/i) 
      # Find scope
      matchobj = line.match(/^Dhcp\ Server.+add scope\ (.*)/i)
      # create a new scope class
      if matchobj
         puts "line: #{linenumber} adding scope #{matchobj[1].to_s}" if @debug
         self.add(matchobj[1].to_s)
         next
      end
      # find scope status and get scope net
      matchobj = line.match(/^Dhcp\ Server\ .+\ Scope\ (\b(?:\d{1,3}\.){3}\d{1,3}\b)\ set\ state\ (\d)/i)
      if matchobj
         puts "line: #{linenumber} adding #{matchobj[1].to_s} state=#{matchobj[2].to_s}" if @debug
         scopeip = matchobj[1]
         self[scopeip].state = matchobj[2]
         next
      end
      # find iprange and get scope net
      matchobj = line.match(/^Dhcp\ Server\ .+\ Scope\ (\b(?:\d{1,3}\.){3}\d{1,3}\b)\ add iprange\ (.*)(BOTH|DHCP|BOOTP)?/i)
      if matchobj
        puts "line: #{linenumber} adding #{matchobj[1].to_s} range=#{matchobj[2].to_s}" if @debug
        scopeip = matchobj[1]
        self[scopeip].option = matchobj[3]
        self[scopeip].startrange = matchobj[2].split(' ')[0]
        self[scopeip].endrange = matchobj[2].split(' ')[1]
        next
      end
      # Get the exclude range and scope
      matchobj = line.match(/^Dhcp\ Server\ .+\ Scope\ (\b(?:\d{1,3}\.){3}\d{1,3}\b)\ add excluderange\ (.*)/i)
      if matchobj
        puts "line: #{linenumber} adding #{matchobj[1].to_s} excluderange=#{matchobj[2].to_s}" if @debug
        scopeip = matchobj[1]
        self[scopeip].addexclusion(matchobj[2].split(' '))
        next
      end
      # get reserved Ip leases and scope ip
      matchobj = line.match(/^Dhcp\ Server\ .+\ Scope\ (\b(?:\d{1,3}\.){3}\d{1,3}\b)\ add reservedip\ (.*)/i)
      if matchobj
          puts "line: #{linenumber} adding #{matchobj[1].to_s} reservedip=#{matchobj[2].to_s}" if @debug
          scopeip = matchobj[1]
          self[scopeip].addlease(matchobj[2].split(' '))
          next
      end
    }
  end 
 
end




