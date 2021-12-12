class Compra
  def initialize(comprador, vendedor, auto)
    raise ErrorVendedorNoEsElPropietario unless vendedor.id == auto.usuario.id

    @comprador = comprador
    @vendedor = vendedor
    @auto = auto
  end

  attr_reader :comprador, :vendedor, :auto
end
