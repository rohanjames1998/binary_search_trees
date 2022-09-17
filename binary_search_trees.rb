#-------------------------------------#
# MODULES
#-------------------------------------#

module BstMethods

  # This method takes an array that has no duplicates and is sorted. It returns the root node
  def build_tree(arr, start=0, end_of_arr=arr.length - 1)
    # Base case is when start is greater than end_of_arr.
    return if start > end_of_arr
    # We set the root node to the mid element of array.
    mid = ((start + end_of_arr)/2).round
    root = Node.new(arr[mid])
    # Then we recursively add left and right child to root using the same logic.
    root.left_child = build_tree(arr, start, mid - 1)
    root.right_child = build_tree(arr, mid + 1, end_of_arr)
    # Finally, we return the root node.
    return root
  end

end








#-------------------------------------#
# CLASSES
#-------------------------------------#

class Node

  include Comparable
  include BstMethods

  attr_accessor :left_child, :right_child, :value

  # Node class can be initialized with one value and
  # two additional nodes. These nodes will be compared
  # and added as left or right child. Both nodes are
  # optional.
  def initialize(value, node_1=nil, node_2=nil)
    @value = value
    @left_child = nil
    @right_child = nil
    if node_1
      node_1.value > value ? right_child = node_1 : left_child = node_1
    elsif node_1 && node_2
      node_1.value > node_2.value ? right_child = node_1 && left_child = node_2 :
      right_child = node_2 && left_child = node_1
    end
  end
end

class Tree

  include BstMethods

  attr_accessor :root

  def initialize(arr)
    # Removing duplicates from array.
    arr.uniq!
    # Sorting the array.
    arr.sort!
    @root = build_tree(arr)
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value)

  case
    when node.value == value
      puts "Error: Cannot insert duplicate node."
      return
    when value < self.node.value
      if self.node.left_child == nil
        self.node.left_child = Node.new(value)
      else
      self.left_child.insert(value)
      end
    when value > self.node.value
      if self.node.right_child == nil
        self.node.right_child = Node.new(value)
      else
        self.right_child.insert(value)
      end
    end
  end


  end

end



my_bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
my_bst.pretty_print
