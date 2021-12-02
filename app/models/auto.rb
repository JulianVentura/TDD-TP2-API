class Auto
  attr_reader :modelo, :kilometros, :anio, :usuario, :estado, :updated_on, :created_on, :precio
  attr_accessor :patente

  ESTADO_AUTO = {
    pendiente: 0,
    cotizado: 1
  }.freeze

  # Crear auto
  def self.crear(patente, modelo, kilometros, anio, usuario)
    Auto.new(patente, modelo, kilometros, anio, usuario, 0, ESTADO_AUTO[:pendiente])
  end

  # Cargar desde la bdd
  def self.crear_desde_repo(patente, modelo, kilometros, anio, usuario, precio, estado) # rubocop:disable Metrics/ParameterLists
    Auto.new(patente, modelo, kilometros, anio, usuario, precio, estado)
  end

  def estado_auto_valor_a_simbolo(valor)
    ESTADO_AUTO.key(valor)
  end

  def cotizar(precio)
    @precio = precio
    @estado = ESTADO_AUTO[:cotizado]
  end

  private

  def initialize(patente, modelo, kilometros, anio, usuario, precio, estado) # rubocop:disable Metrics/ParameterLists
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @usuario = usuario
    @precio = precio
    @estado = estado
  end
end
