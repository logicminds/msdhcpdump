class Reservation 
  attr_accessor :ip, :mac, :hostname, :comment, :option
  def initialize(reserve=[])
    @ip = reserve[0]
    @mac = reserve[1]
    @hostname = reserve[2]
    @comment = reserve[3]
    @option = reserve[4]
  end
  def to_s
    return "#{@ip} - #{@mac} - #{@hostname} - #{@comment} - #{@option}\n"
  end
end
