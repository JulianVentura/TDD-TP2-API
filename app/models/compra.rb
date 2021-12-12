class Compra
  def initialize(comprador, vendedor, auto)
    raise ErrorVendedorNoEsElPropietario unless vendedor.id == auto.usuario.id
    raise ErrorVendedorNoPuedeComprarSuPropioAuto if vendedor.id == comprador.id

    @comprador = comprador
    @vendedor = vendedor
    @auto = auto
  end

  attr_reader :comprador, :vendedor, :auto
end
