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

def reset_url
  "#{BASE_URL}/reset"
end

def id_falso
  4506958
end

After do |_scenario|
  Faraday.post(reset_url)
end
