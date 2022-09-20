#-------------------------------------#
# MODULES
#-------------------------------------#

module BstMethods
  # This method takes an array that has no duplicates and is sorted. It returns the root node
  def build_tree(arr, start = 0, end_of_arr = arr.length - 1)
    # Base case is when start is greater than end_of_arr.
    return if start > end_of_arr

    # We set the root node to the mid element of array.
    mid = ((start + end_of_arr) / 2).round
    root = Node.new(arr[mid])
    # Then we recursively add left and right child to root using the same logic.
    root.left_child = build_tree(arr, start, mid - 1)
    root.right_child = build_tree(arr, mid + 1, end_of_arr)
    # Finally, we return the root node.
    return root
  end

  # This method takes a value and a root node, and inserts that value as a node in the tree.
  def insert_node(value, root_node)
    case
      # Check for duplicate
    when root_node.value == value
      puts "Error: Cannot insert duplicate node."
      return
    when value < root_node.value
      # If value is less than root value and root node doesn't have a left_child, insert value
      # as the left child else recursively call #insert_node on root's left_child.
      if root_node.left_child == nil
        root_node.left_child = Node.new(value)
      else
        root_node.insert_node(value, root_node.left_child)
      end
    when value > root_node.value
      # We do the same thing we did for left_child.
      if root_node.right_child == nil
        root_node.right_child = Node.new(value)
      else
        root_node.insert_node(value, root_node.right_child)
      end
    end
  end

  # This method finds the node containing the given value.
  def find_val(value, node)
    # Base case if we find the value we return the node. Else if the node
    # Does not exist, we return nil.
    if node.value == value
      return node
    elsif node.value == nil
      return nil
    end

    if node.value > value
      find_val(value, node.left_child)
    else
      find_val(value, node.right_child)
    end
  end

  # This method assumes that the node has two child nodes and the tree is balanced,
  # and returns the successor node. If the successor node has a right child,
  # it makes the right child the left child of the node before the successor node.
  # This method returns the value of successor node.
  def find_successor_val(node)
    # Because we need to know the node before the successor node, we check for the right child
    # of the last left node in advance.
    if node.left_child.nil? && node.right_child.nil?
      successor_val = node.value
      node.value = nil
      return successor_val
    elsif node.left_child.left_child.nil? && node.left_child.right_child != nil
      previous_node = node
      successor_node = node.left_child
      successor_val = successor_node.value
      previous_node.left_child = successor_node.right_child
      successor_node.right_child = nil
      successor_node.value = nil
      return successor_val
    else
      find_successor_val(node.left_child)
    end
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
  def initialize(value, node_1 = nil, node_2 = nil)
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

  # This method mainly calls insert_node method.
  def insert(value)
    insert_node(value, self.root)
  end

  # This method deletes the node containing given value. This method assumes
  # that the tree given is balanced.
  def delete(value)
    node_to_delete = find_val(value, self.root)

    case
      # If the node doesn't have any child nodes, we simply delete it.
    when node_to_delete.left_child == nil && node_to_delete.right_child == nil
      node_to_delete.value = nil
      # If the node has only a left child, make left_child the successor node.
    when node_to_delete.left_child != nil && node_to_delete.right_child == nil
      node_to_delete.value = node_to_delete.left_child.value
      # If the node only has a right child, make right_child the successor node.
    when node_to_delete.right_child != nil && node_to_delete.left_child == nil
      node_to_delete.value = node_to_delete.right_child.value
      # If node has two child nodes, we find the successor node and swap it with node_to_delete.
    else
      # Since we need to first visit the node_to_delete's right child then traverse through it's
      # left children we pass node_to_delete.right_child into find successor_val.
      successor_val = find_successor_val(node_to_delete.right_child)
      node_to_delete.value = successor_val
    end
  end

  # This method mainly calls find_val method.
  def find(value)
    find_val(value, self.root)
  end

  # This method traverses the tree in level order and yields each node in the same order.
  # If no block is given it returns an array of all nodes in level order.
  def level_order
    current_node = self.root
    level_order_nodes = []
    level_order_nodes << current_node
    lvl_order_vals = []
    i = 0

    if block_given?
      loop do
        current_node = level_order_nodes[i]
        break if current_node == nil

        yield current_node
        i += 1
        if current_node.left_child
          level_order_nodes << current_node.left_child
        end
        if current_node.right_child
          level_order_nodes << current_node.right_child
        end
      end
    else
      loop do
        current_node = level_order_nodes[i]
        break if current_node == nil

        lvl_order_vals << current_node.value
        i += 1
        if current_node.left_child
          level_order_nodes << current_node.left_child
        end
        if current_node.right_child
          level_order_nodes << current_node.right_child
        end
      end
      return lvl_order_vals
    end
  end

  # This method mainly calls two functions. If block is given it calls a function that yields nodes in pre-order.
  # Else it returns an array of values (of nodes) in pre-order.
  def preorder(node=self.root, output =[], &block)
    return if node == nil
    output.push(block_given? ? block.call(node): node.value)
    preorder(node.left_child, output, &block)
    preorder(node.right_child, output, &block)
    output
  end

  def inorder(node=self.root, output =[], &block)
    return if node == nil
    inorder(node.left_child, output, &block)
    output.push(block_given? ? block.call(node): node.value)
    inorder(node.right_child, output, &block)
    output
  end

end

my_bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
my_bst.insert(99)
# my_bst.delete(8)
my_bst.pretty_print


