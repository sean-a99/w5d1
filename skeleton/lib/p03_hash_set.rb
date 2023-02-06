class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets

    unless self[key.hash].include?(key)
      self[key.hash] << key 
      @count += 1
    end

  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if self[key.hash].include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = @store.flatten

    @store = Array.new(num_buckets * 2) { Array.new }
    elements.each { |key| self[key.hash] << key }
  end
end
