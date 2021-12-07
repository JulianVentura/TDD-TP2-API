require_relative 'estado'

class Auto
  attr_reader :modelo, :kilometros, :anio, :usuario, :estado, :updated_on, :created_on, :precio
  attr_accessor :patente

  # Crear auto
  def self.crear(patente, modelo, kilometros, anio, usuario)
    Auto.new(patente, modelo, kilometros, anio, usuario, 0, EnRevision.new)
  end

  # Cargar desde la bdd
  def self.crear_desde_repo(patente, modelo, kilometros, anio, usuario, precio, estado) # rubocop:disable Metrics/ParameterLists
    Auto.new(patente, modelo, kilometros, anio, usuario, precio, estado)
  end

  def cotizar(precio)
    @precio = @estado.cotizar(precio)
    @estado = Cotizado.new
  end

  def vender_a_fiubak
    @estado.cotizado?
    @estado = EsperandoEntrega.new
  end

  def publicar(tasa, usuario_fiubak)
    @estado.entregar_llave?
    @precio = precio * (100 + tasa) / 100
    @estado = Publicado.new
    cambiar_de_propietario(usuario_fiubak)
  end

  def publicar_p2p(precio)
    @estado.cotizado?
    raise ErrorPrecioMenorACotizado if precio <= @precio

    @precio = precio
    @estado = Publicado.new
  end

  def comprar
    @estado.esta_publicado? # TODO: El auto deberia hacer el raise?
    @estado = Vendido.new
  end

  def esta_publicado?
    @estado.esta_publicado?
  end

  def propietario_es_particular?
    @usuario.es_particular?
  end

  private

  def initialize(patente, modelo, kilometros, anio, usuario, precio, estado) # rubocop:disable Metrics/ParameterLists
    raise ErrorFaltanArgumentos if [patente, modelo, anio, kilometros, usuario, precio, estado].any? nil

    @patente = patente.upcase
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @usuario = usuario
    @precio = precio
    @estado = estado
  end

  def cambiar_de_propietario(usuario)
    @usuario = usuario
  end
end
