#-------------------------------------#
# MODULES
#-------------------------------------#

module BstMethods

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
    @left_child =
    @right_child =
  end
end

class Tree

