class Oferta
  # Crear oferta
  def self.crear(auto, ofertante, precio)
    raise ErrorAutoNoEstaPublicado unless auto.esta_publicado?

    Oferta.new(auto, ofertante, precio, nil) # TODO: Chequear el valor inicial de id
  end

  def self.crear_desde_repo(auto, ofertante, precio, id)
    Oferta.new(auto, ofertante, precio, id)
  end

  attr_reader :auto, :ofertante, :precio, :updated_on, :created_on
  attr_accessor :id

  private

  def initialize(auto, ofertante, precio, id_oferta)
    raise ErrorOfertaInvalida if precio.nil? || precio.negative?

    @auto = auto
    @ofertante = ofertante
    @precio = precio
    @id = id_oferta
  end
end
