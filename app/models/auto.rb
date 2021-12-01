class Auto
  attr_reader :patente, :modelo, :kilometros, :anio, :estado, :updated_on, :created_on
  attr_accessor :id

  ESTADO_AUTO = {
    pendiente: 0,
    cotizado: 1
  }.freeze

  def initialize(patente, modelo, kilometros, anio, id = nil)
    @id = id
    @patente = patente
    @modelo = modelo
    @kilometros = kilometros
    @anio = anio
    @estado = ESTADO_AUTO[:pendiente]
    # TODO: agregar id del usuario que registro el auto
  end

  def estado_auto_valor_a_simbolo(valor)
    ESTADO_AUTO.key(valor)
  end
end
