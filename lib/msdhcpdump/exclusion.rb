class Exclusion
  attr_accessor :startrange, :endrange
  def initialize(range=[])
    @startrange = range[0]
    @endrange = range[1]
  end
  def to_s
     return "#{@startrange} - #{@endrange}\n" 
  end
end
