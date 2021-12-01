class Auto
  attr_reader :modelo, :kilometros, :anio, :usuario, :estado, :updated_on, :created_on
  attr_accessor :patente

  ESTADO_AUTO = {
    pendiente: 0,
    cotizado: 1
  }.freeze

  def initialize(patente, modelo, kilometros, anio, usuario)
    @usuario = usuario
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @estado = ESTADO_AUTO[:pendiente]
  end

  def estado_auto_valor_a_simbolo(valor)
    ESTADO_AUTO.key(valor)
  end
end
