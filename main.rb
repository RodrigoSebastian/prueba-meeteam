require './node'

def test1()
  # Crear nodos
  node1 = Node.new(1)
  node2 = Node.new(2)
  node3 = Node.new(3)
  node4 = Node.new(4)
  node5 = Node.new(5)
  node6 = Node.new(6)

  # Conectar todos los nodos
  node1.add_neighbor(node2)
  node1.add_neighbor(node3)
  node1.add_neighbor(node4)
  node1.add_neighbor(node5)
  node1.add_neighbor(node6)

  node2.add_neighbor(node1)
  node2.add_neighbor(node3)
  node2.add_neighbor(node4)
  node2.add_neighbor(node5)
  node2.add_neighbor(node6)

  node3.add_neighbor(node1)
  node3.add_neighbor(node2)
  node3.add_neighbor(node4)
  node3.add_neighbor(node5)
  node3.add_neighbor(node6)

  node4.add_neighbor(node1)
  node4.add_neighbor(node2)
  node4.add_neighbor(node3)
  node4.add_neighbor(node5)
  node4.add_neighbor(node6)

  node5.add_neighbor(node1)
  node5.add_neighbor(node2)
  node5.add_neighbor(node3)
  node5.add_neighbor(node4)
  node5.add_neighbor(node6)

  # Mostrar vecinos iniciales
  [node1, node2, node3, node4, node5, node6].each do |node|
    node.show_neighbors()
  end

  # Proponer estados
  node1.propose_state(5)
  node4.propose_state(8)
  node5.propose_state(1)

  # Simular partición
  node5.simulate_partition([node1, node2])

  # Nodo 5 propone un nuevo estado mientras Nodo 3 está aislado
  node5.propose_state(15)

  # Restaurar partición
  node5.restore_partition

  node5.propose_state(20)

  # Logs finales
  [node1, node2, node3, node4, node5].each do |node|
    puts node.retrieve_log
  end
end

def test2()
  # Crear nodos
  node1 = Node.new(1)
  node2 = Node.new(2)
  node3 = Node.new(3)

  # Mostrar vecinos iniciales
  [node1, node2, node3].each do |node|
    node.show_neighbors()
  end

  # Agregar vecinos
  node1.add_neighbor(node2)
  node1.add_neighbor(node3)

  node2.add_neighbor(node1)
  node2.add_neighbor(node3)

  node3.add_neighbor(node1)
  node3.add_neighbor(node2)

  # Proponer estados
  node1.propose_state(5)

  # Simular partición
  node3.simulate_partition([node1, node2])

  # Nodo 2 propone un estado más alto
  node2.propose_state(10)

  # Restaurar partición
  node3.restore_partition

  # Logs
  puts "\nLogs de los nodos:"
  puts node1.retrieve_log
end

puts "Test 1:"
test1()
# puts "\nTest 2:"
# test2()