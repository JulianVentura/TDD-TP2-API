class Compra
  def initialize(comprador, vendedor, auto)
    @comprador = comprador
    @vendedor = vendedor
    @auto = auto
  end

  attr_reader :comprador, :vendedor, :auto
end
