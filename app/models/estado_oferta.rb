class EstadoOferta

  def ==(other)
    other.estado == @estado
  end

  def pendiente?
    false
  end

  attr_reader :estado

  protected

  def initialize(estado)
    @estado = estado
  end
end

class Pendiente < EstadoOferta
  def initialize
    super(:pendiente)
  end

  def pendiente?
    true
  end
end

class Rechazado < EstadoOferta
  def initialize
    super(:rechazado)
  end
end

class Aceptado < EstadoOferta
  def initialize
    super(:aceptado)
  end
end
