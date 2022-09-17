#-------------------------------------#
# MODULES
#-------------------------------------#

module BstMethods

  def build_tree(arr, start=0, end=arr.length - 1)

    return if start > end

    mid = (start + end)/2
    root = Node.new(arr[mid])

    root.left_child = build_tree(arr, start, mid - 1)
    root.right_child = build_tree(arr, mid + 1, end)
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
      node_1.value > node_2.value ? right_child = node_1; left_child = node_2 : right_child = node_2; left_child = node_1
    end
  end
end

class Tree

  include BstMethods

  def initialize(arr)
    # Removing duplicates from array
    @root = build_tree(arr)
  end

end

