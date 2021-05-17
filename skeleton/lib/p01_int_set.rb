require 'set'
class MaxIntSet

  attr_reader :store

  def initialize(max)
    @store = Array.new(max,false)
    # @store = Set.new()
  end

  # def [](num)
  #   @store[num]
  # end

  # def [](num)
  # end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num)
    if @store[num] == false
      @store[num] = true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return false if @store[num] == false
    return true if @store[num] == true
  end

  private

  def is_valid?(num)
    return false if num < 0 || num > @store.length
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    i = num % 20
    @store[i]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      self[num].push(num) 

    # self.count
    @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      # self.count
      @count -= 1
    end
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  def count
    @count
  end

  private

  def [](num)
    i = num % @store.length
    @store[i]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |num| insert(num) }
  end
end
