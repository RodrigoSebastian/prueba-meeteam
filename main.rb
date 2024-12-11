require './node.rb'

node1 = Node.new(1)
node1.add_neighbor(Node.new(2))
node1.add_neighbor(Node.new(3))
node1.add_neighbor(Node.new(4))
node1.add_neighbor(Node.new(5))
node1.add_neighbor(Node.new(6))

node1.show_neighbors()