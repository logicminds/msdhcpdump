class Scope
  attr_accessor :name, :net, :mask, :state, :desc, :option, :exclusions, :reserved, :reservations, :startrange, :endrange

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
    @reservations = Hash.new
  end
  def setstate value
    @state = value
  end
  def addexclusion(range=[])
    @exclusions << Exclusion.new(range)
  end
  def active?
    return @state.to_i == 1
  end
  def listreservations
    @reservations.keys
  end
  def getreservations
    @reservations.values
  end
  def to_s
     p= Array.new
     p[0] = "Scope Network: #{@net}"
     p[1] = "Scope Netmask: #{@mask}"
     p[2] = "Scope Range: #{@startrange} - #{@endrange}"
     p[3] = "Scope Name:  #{@name}"
     p[4] = "Scope option:  #{@option}" 
     p[5] = "Scope desc: #{@desc}"
     p[6] = "Scope active status: #{state}"
     p[7] = "Scope IP exclusions: \n#{@exclusions}"
     p[8] = "Scope current reservations: \n#{getreservations.to_s}"
     p[9] = "\n"
     return p
     
  end
  def addreservation(reservation=[])
    newreservation = Reservation.new(reservation)
    @reservations[newreservation.mac] = newreservation

  end
end
