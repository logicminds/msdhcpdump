Gem::Specification.new do |s|
  s.name = %q{msdhcpdump}
  s.author = "Corey Osman"
  s.email = "corey@logicminds.biz"
  s.homepage = "http://github.com/logicminds/msdhcpdump"
  s.version = "0.1.1"
  s.date = %q{2011-11-02}
  s.summary = %q{Gem to parse Microsoft DHCP server dump}
  s.description = "Easy way to parse a Microsoft DHCP dump of scopes"
  s.files = [
    "lib/msdhcpdump/exclusion.rb",
    "lib/msdhcpdump/lease.rb",
    "lib/msdhcpdump/scope.rb",
    "lib/msdhcpdump/msdhcpdump.rb",
    "test.rb",
    "sampledump.txt",
    "msdhcpdump.gemspec",
  ]
  s.require_paths = ["lib"]
end

