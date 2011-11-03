class Scope
  attr_accessor :net, :mask, :title, :state, :desc, :option, :exclusions, :reserved, :leases, :startrange, :endrange

  def initialize(matchobj)
    scopearray = matchobj.split(' ',3).to_a
   
    @net = scopearray[0]
    @mask = scopearray[1]
    @title = scopearray[2].match(/([\w+\ ?]+)/i)[1]
    # TODO Find out how to parse the description out
    @desc = nil
    @option = nil
    @exclusions = Array.new
    @reserved = Array.new
    @leases = Array.new
  end
  def setstate value
    @state = value
  end
  def addexclusion(range=[])
    @exclusions << Exclusion.new(range)
    
  end
  def listleases
    
  end
  def to_s
     p= Array.new
     p[0] = "Scope Network: #{@net}"
     p[1] = "Scope Netmask: #{@mask}"
     p[2] = "Scope Range: #{@startrange} - #{@endrange}"
     p[3] = "Scope Title:  #{@title}"
     p[4] = "Scope option:  #{@option}" 
     p[5] = "Scope desc: #{@desc}"
     p[6] = "Scope active status: #{state}"
     p[7] = "Scope IP exclusions: \n#{@exlusions.to_s}"
     p[8] = "Scope current reservations: \n#{@leases.to_s}"
     p[9] = "\n"
     return p
     
  end
  def addlease(lease=[])
    @leases << Lease.new(lease)

  end
end
