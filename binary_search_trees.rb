#-------------------------------------#
# MODULES
#-------------------------------------#










#-------------------------------------#
# CLASSES
#-------------------------------------#

class Node

  include Comparable
  include 

  attr_accessor :left_child, :right_child

  def initialize(value, left=nil, right=nil)
    @value = value
    @left_child = check_val(left, right)
    @right_child = check_val(left, right)
  end
end

class Tree

