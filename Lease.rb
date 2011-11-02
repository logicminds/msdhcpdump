class Lease
  attr_accessor :ip, :mac, :hostname, :comment, :option
  def initialize(lease=[])
    @ip = lease[0]
    @mac = lease[1]
    @hostname = lease[2]
    @comment = lease[3]
    @option = lease[4]
  end
end
