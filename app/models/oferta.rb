class Oferta
  # Crear oferta
  def self.crear(auto, ofertante, precio)
    raise ErrorAutoNoEstaPublicado unless auto.esta_publicado?

    Oferta.new(auto, ofertante, precio, nil, Pendiente.new) # TODO: Chequear el valor inicial de id
  end

  def self.crear_desde_repo(auto, ofertante, precio, id, estado)
    Oferta.new(auto, ofertante, precio, id, estado)
  end

  def rechazar
    raise ErrorOfertaNoPendiente unless @estado.pendiente?

    @estado = Rechazado.new
  end

  def obtener_id_propietario
    @auto.usuario.id
  end

  attr_reader :auto, :ofertante, :precio, :updated_on, :created_on, :estado
  attr_accessor :id

  private

  def initialize(auto, ofertante, precio, id_oferta, estado)
    raise ErrorOfertaInvalida if precio.nil? || precio.negative?

    @auto = auto
    @ofertante = ofertante
    @precio = precio
    @id = id_oferta
    @estado = estado
  end
end
