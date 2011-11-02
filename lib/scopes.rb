require 'lease'
require 'scope'
require 'exclusion'


class Scopes << Hash
  def initialize(dhcpdump)
    super()
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
  
  private 
  def processdump(dhcpdump)
     dhcpdump.each {|line|
      # Ignore all comments
      next if line.match(/^\#/)
      # Ignore all scope set optionvalue
      next if line.match(/.+Scope.+\ set\ optionvalue/i)
      # Find scope
      matchobj = line.match(/^Dhcp\ Server.+(add scope)\ (.*)/i)
      # create a new scope class
      if matchobj
         self.add(matchobj)
         next
      end
      # find scope status and get scope net
      matchobj = line.match(/^Dhcp\ Server (\b(?:\d{1,3}\.){3}\d{1,3}\b).+set state\ (.*)/i)
      if matchobj
         self[matchobj[1]].state = matchobj[2]
         next
      end
      # find iprange and get scope net
      matchobj = line.match(/^Dhcp\ Server (\b(?:\d{1,3}\.){3}\d{1,3}\b).+add iprange\ (.*)(BOTH|DHCP|BOOTP)/i)
      if matchobj
        self[matchobj[1]].option = matchobj[3]
        self[matchobj[1]].startrange = matchobj[2].split(' ')[0]
        self[matchobj[1]].endrange = matchobj[2].split(' ')[1]
        next
      end
      # Get the exclude range and scope
      matchobj = line.match(/^Dhcp\ Server (\b(?:\d{1,3}\.){3}\d{1,3}\b).+add excluderange\ (.*)/i)
      if matchobj
        self[matchobj[1]].addexclusion(matchobj[2].split(' ')
        next
      end
      # get reserved Ip leases and scope ip
      matchobj = line.match(/^Dhcp\ Server (\b(?:\d{1,3}\.){3}\d{1,3}\b).+add reservedip\ (.*)/i)
      if matchobj
          self[matchobj[1]].addlease(matchobj[2].split(' '))
          next
      end
    }
  end 
 
end




