# rubocop:disable all
ENV['RACK_ENV'] = 'test'
ENV['ENABLE_RESET'] = 'true'

require File.expand_path("#{File.dirname(__FILE__)}/../../config/boot")

require 'rspec/expectations'

if ENV['BASE_URL']
  BASE_URL = ENV['BASE_URL']
else
  BASE_URL = 'http://localhost:3000'.freeze
  include Rack::Test::Methods
  def app
    Padrino.application
  end
end

def header
  {'Content-Type' => 'application/json'}
end

def crear_url_usuarios
  "#{BASE_URL}/usuarios"
end

def crear_url_autos
  "#{BASE_URL}/autos"
end

def crear_url_autos_usuario(id_prop)
  "#{BASE_URL}/usuarios/#{id_prop}/autos"
end

def cotizar_url_autos(patente)
  "#{BASE_URL}/autos/#{patente}/cotizar"
end

def vender_url_autos(patente)
  "#{BASE_URL}/autos/#{patente}/vender_a_fiubak"
end

def entregar_llaves_url_autos(patente)
  "#{BASE_URL}/autos/#{patente}/entregar_llaves"
end

def publicar_p2p_url_autos(patente)
  "#{BASE_URL}/autos/#{patente}/publicar_p2p"
end

def listar_autos_url
  "#{BASE_URL}/autos"
end

def reset_url
  "#{BASE_URL}/reset"
end

def id_falso
  4506958
end

After do |_scenario|
  Faraday.post(reset_url)
end

def registrar_auto(modelo, patente, kilometros, anio)
  request_registro_auto = {
    :patente => patente,
    :modelo => modelo,
    :kilometros => kilometros,
    :anio => anio,
    :id_prop => id_falso
  }.to_json

  Faraday.post(crear_url_autos, request_registro_auto, header)
end

def cotizar_auto(patente, precio)
  body = {:precio => precio}.to_json
  Faraday.patch(cotizar_url_autos(patente), body, header)
end

def vender_a_fiubak(patente)
  body = {
    :id_prop => id_falso,
  }.to_json
  Faraday.post(vender_url_autos(patente), body, header)
end

def entregar_llaves(patente)
  Faraday.post(entregar_llaves_url_autos(patente), nil, header)
end
