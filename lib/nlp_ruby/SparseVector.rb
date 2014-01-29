class SparseVector < Hash

  def initialize
    super
    self.default = 0
  end

  def from_hash h
    h.each_pair { |k,v| self[k] = v }
  end

  def sum
    self.values.inject(:+)
  end

  def average
    self.sum/self.size.to_f
  end

  def variance
    avg = self.average
    var = 0.0
    self.values.each { |i| var += (avg - i)**2 }
    return var
  end

  def stddev
    Math.sqrt self.variance
  end

  def dot other
    sum = 0.0
    self.each_pair { |k,v| sum += v * other[k] }
    return sum
  end

  def magnitude
    Math.sqrt self.values.inject { |sum,i| sum+i**2 }
  end

  def cosinus_sim other
    self.dot(other)/(self.magnitude*other.magnitude)
  end

  def euclidian_dist other
    dims = [self.keys, other.keys].flatten.uniq
    sum = 0.0
    dims.each { |d| sum += (self[d] - other[d])**2 }
    return Math.sqrt(sum)
  end
end

def mean_sparse_vector array_of_vectors
  mean = SparseVector.new
  array_of_vectors.each { |i|
    i.each_pair { |k,v|
      mean[k] += v
    }
  }
  n = array_of_vectors.size.to_f
  mean.each_pair { |k,v| mean[k] = v/n }
  return mean
end

