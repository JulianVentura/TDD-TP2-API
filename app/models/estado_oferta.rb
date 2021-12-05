class EstadoOferta
  def initialize(estado)
    @estado = estado
  end

  def ==(other)
    other.estado == @estado
  end

  attr_reader :estado
end

class Pendiente < EstadoOferta
  def initialize
    super(:pendiente)
  end
end

class Rechazado < EstadoOferta
  def initialize
    super(:rechazado)
  end
end
