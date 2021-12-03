# rubocop:disable all
require 'spec_helper'

RSpec.configure do |config|
  # config.include UserFactory
  config.after :each do
    # Persistence::Repositories::TaskRepository.new.delete_all
    Persistence::Repositories::RepositorioAuto.new.delete_all
    Persistence::Repositories::RepositorioUsuario.new.delete_all
  end
end

def crear_auto_publicado(patente, propietario, creador_auto, cotizador_auto, vendedor_auto, entrega)
  modelo = 'Fiat'
  precio = 30_000
  anio = 2004
  cotizacion = 15_000
  creador_auto.crear_auto(patente, modelo, precio, anio, propietario.id)
  cotizador_auto.cotizar(patente, cotizacion)
  vendedor_auto.vender_a_fiubak(patente, propietario.id)
  entrega.entregar_llaves(patente)
end

def crear_auto_cotizado(patente, propietario, creador_auto, cotizador_auto)
  modelo = 'Fiat'
  precio = 30_000
  anio = 2004
  cotizacion = 15_000
  creador_auto.crear_auto(patente, modelo, precio, anio, propietario.id)
  cotizador_auto.cotizar(patente, cotizacion)
end