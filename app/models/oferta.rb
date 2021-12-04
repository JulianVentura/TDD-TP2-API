class Oferta
  # Crear oferta
  def self.crear(auto, ofertante, precio)
    raise ErrorAutoNoEstaPublicado unless auto.esta_publicado?

    Oferta.new(auto, ofertante, precio, nil) # TODO: Chequear el valor inicial de id
  end

  attr_reader :auto, :ofertante, :precio, :updated_on, :created_on
  attr_accessor :id

  private

  def initialize(auto, ofertante, precio, id_oferta)
    @auto = auto
    @ofertante = ofertante
    @precio = precio
    @id = id_oferta
  end
end
