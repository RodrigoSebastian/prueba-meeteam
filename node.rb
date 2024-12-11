class Node
  attr_reader :id, :state, :log, :neighbors

  # Constructor
  def initialize(id)
    @id = id
    @state = nil
    @log = ["Nodo con ID '#{id}' creado"]
    @neighbors = []
  end

  # Agrega un nodo vecino
  def add_neighbor(node)
    unless @neighbors.include?(node)
      @neighbors << node
    end
  end

  # Muestra todos los vecinos
  def show_neighbors()
    @neighbors.each do |neighbor|
      puts "Vecino: #{neighbor.id}"
    end
  end

  # Envía un mensaje a los vecinos
  def send_message(message)
    log_event("Mensaje: #{message}")

    @neighbors.each do |neighbor|
      neighbor.receive_message(message, self)
    end
  end

  # Recibe un mensaje de otro nodo
  def receive_message(message, sender)
    log_event("Recibido mensaje: #{message} de Nodo #{sender.id}")
  end

  # Recupera el registro de eventos
  def retrieve_log
    @log
  end

  private

  # Registra eventos en el log
  def log_event(event)
    @log << { timestamp: Time.now, event: event }
  end
end