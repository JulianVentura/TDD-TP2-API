require 'spec_helper'

describe 'CotizadorAuto' do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }

  it 'deberia cotizar un auto' do
    patente = 'AA752OH'
    modelo = 'Fiat'
    anio = 1999
    kilometros = 4000

    un_usuario = creador_usuario.crear_usuario('Juan', 123, 'juan@email.com')
    creador_auto.crear_auto(patente, modelo, anio, kilometros, un_usuario.id)

    precio = 12_000
    auto = CotizadorAuto.new(repo_auto).cotizar(patente, precio)
    expect(auto.precio).to eq precio
  end

  it 'deberia fallar si el auto no existe' do
    patente = 'AA752OH'

    precio = 12_000
    expect  do
      CotizadorAuto.new(repo_auto).cotizar(patente, precio)
    end.to raise_error(ErrorAutoNoExiste)
  end
end
