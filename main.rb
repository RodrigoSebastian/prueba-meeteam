require './node'

# Crear nodos
node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)

# Agregar vecinos
node1.add_neighbor(node2)
node1.add_neighbor(node3)

node2.add_neighbor(node1)
node2.add_neighbor(node3)

node3.add_neighbor(node1)
node3.add_neighbor(node2)

# Proponer estados
puts "Nodo 1 propone estado 1"
node1.propose_state(1)

puts "Nodo 2 propone estado 2"
node2.propose_state(2)

puts "Nodo 2 propone estado 3"
node2.propose_state(3)

# Logs
puts "\nLogs de los nodos:"
puts "Log Nodo 1:"
puts node1.retrieve_log

puts "\nLog Nodo 2:"
puts node2.retrieve_log

puts "\nLog Nodo 3:"
puts node3.retrieve_log