class Scopes << Hash
  def initialize
    super()
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

 
end




