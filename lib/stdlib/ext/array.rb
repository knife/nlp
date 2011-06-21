class Array
  def tail
    self[1..-1]
  end

  def mean
    sum=0
    self.each{|v| sum+=v }
    sum/self.size
  end

end

