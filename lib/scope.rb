class Scope
  attr_accessor :net, :mask, :title, :state, :desc, :option, :exclusions, :reserved, :leases, :startrange, :endrange

  def initialize(matchobj)
    scopearray = newscopeobj.split(' ',3).to_a
   
    @net = scopearray[0]
    @mask = scopearray[1]
    @title = scopearray[2].match(/([\w+\ ?]+)/i)[1]
    # TODO Find out how to parse the description out
    @desc = nil
    @option = nil
    @exclusions = Array.new
    @reserved = Array.new
  end

  def addexclusion(range=[])
    @exclusions << Exclusion.new(range)
    
  end
  def listleases
    
  end

  def addlease(lease=[])
    @leases << Lease.new(lease)

  end
end
