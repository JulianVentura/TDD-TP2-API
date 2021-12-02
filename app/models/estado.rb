class Estado
  def initialize(estado)
    @estado = estado
  end

  def cotizar(precio)
    raise ErrorNoCotizable
  end
end

class Cotizado < Estado
  def initialize()
    super(:cotizado)
  end
end
