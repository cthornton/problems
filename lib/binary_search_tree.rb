# Implementation of a binary search tree in Ruby
module BinarySearchTree

  class Node
    attr_reader :key, :value
    attr_reader :left, :right

    def initialize(key, value)
      @key   = key
      @value = value
    end

    # Inserts a new node
    def insert(node)
      if node.key == key
        @value = node.value
      elsif node.key < key
        @left.nil? ? @left = node : @left.insert(node)
      else
        @right.nil? ? @right = node : @right.insert(node)
      end
      return nil
    end

    def find(key)
      return value if @key == key
      if key < @key
        return left.find(key) unless left.nil?
      else
        return right.find(key) unless right.nil?
      end
      return nil
    end
    alias_method :[], :find

    def size
      count = 1
      count += left.size unless left.nil?
      count += right.size unless right.nil?
      return count
    end
    alias_method :length, :size

    def []=(key,value)
      insert(self.class.new key, value)
    end

    protected

    def left=(node)
      @left = node
    end

    def right=(node)
      @right = node
    end

  end
end
