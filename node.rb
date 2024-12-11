class Node
  attr_reader :id, :state, :log, :neighbors

  # Constructor
  def initialize(id)
    @id = id
    @state = nil
    @log = []
    @neighbors = []
    @accepted_states = {}            # Estados propuestos aceptados por este nodo
    @votes = {}                      # Votos recibidos para cada estado
  
    log_event("Nodo con ID '#{id}' creado")
  end

  # Agrega un nodo vecino
  def add_neighbor(node)
    unless @neighbors.include?(node)
      log_event("Vecino agregado: #{node.id}")
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
    log_event("Enviando mensaje: #{message}")

    @neighbors.each do |neighbor|
      neighbor.receive_message(message, self)
    end
  end

  # Recibe un mensaje de otro nodo
  # y realiza una acción dependiendo del tipo de mensaje
  def receive_message(message, sender)
    log_event("Recibido mensaje: #{message} de Nodo #{sender.id}")

    case message[:type]
    when :proposal
      handle_proposal(message[:state], sender)
    when :vote
      handle_vote(message[:state], sender)
    end
  end

  # Proponer un nuevo estado
  def propose_state(new_state)
    log_event("Proponiendo nuevo estado: #{new_state}")

    @state = new_state
    @votes[new_state] = 1
    send_message({ type: :proposal, state: new_state })
  end

  # Maneja un mensaje de voto
  def handle_vote(state, sender)
    @votes[state] ||= 0
    @votes[state] += 1

    if @votes[state] > majority_threshold
      log_event("Consenso alcanzado con estado: #{state}")
      @state = state
    end
  end

  # Calcula el umbral de mayoría
  def majority_threshold
    (@neighbors.size + 1) / 2
  end

  # Recupera el registro de eventos
  def retrieve_log
    formatted_log = "Log del Nodo #{@id}:\n"
    @log.each do |entry|
      timestamp = entry[:timestamp].strftime('%Y-%m-%d %H:%M:%S')
      formatted_log += "[#{timestamp}] #{entry[:event]}\n"
    end

    formatted_log
  end

  private

  # Registra eventos en el log
  def log_event(event)
    @log << { timestamp: Time.now, event: event }
  end

  # Maneja un mensaje de propuesta
  def handle_proposal(state, sender)
    if @accepted_states[state].nil? || state > @accepted_states[state]

      @accepted_states[state] = state
      log_event("Aceptando estado propuesto: #{state}")
      send_message({ type: :vote, state: state })

    else
      log_event("Rechazando estado propuesto: #{state}")
    end
  end
end