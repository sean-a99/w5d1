class HashSet

  attr_reader :store, :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    unless include?(key)
      self[key] << key 
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    store[key.hash % num_buckets]
  end

  def num_buckets
    store.count
  end

  def resize!
    keys = store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    keys.each { |key| insert(key) }
  end

end

h = HashSet.new
h.insert("howdy")
p h.include?("howdy")