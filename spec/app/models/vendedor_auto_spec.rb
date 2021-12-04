require 'spec_helper'

describe VendedorAuto do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }

  context 'ya existe un auto cotizado' do
    let(:patente) { 'AA752OH' }
    let(:propietario) { creador_usuario.crear_usuario('Juan', 123, 'juan@email.com') }

    before :each do
      modelo = 'Fiat'
      anio = 1999
      kilometros = 4000
      creador_auto.crear_auto(patente, modelo, anio, kilometros, propietario.id)

      precio = 12_000
      cotizador_auto.cotizar(patente, precio)
    end

    it 'deberia cambiar su estado al vender un auto a fiubak' do
      auto_vendido = described_class.new(repo_auto, repo_usuario).vender_a_fiubak(patente, propietario.id)
      estado_esperado = EsperandoEntrega.new
      expect(auto_vendido.estado).to eq estado_esperado
    end

    it 'deberia dar error si el usuario no es el propietario del auto' do
      no_propietario = creador_usuario.crear_usuario('NoJuan', 555, 'nojuan@email.com')
      expect do
        described_class.new(repo_auto, repo_usuario).vender_a_fiubak(patente, no_propietario.id)
      end.to raise_error(ErrorUsuarioNoEsElPropietario)
    end

    it 'deberia dar error si el auto no existe' do
      patente_no_existente = 'ABC123'
      expect do
        described_class.new(repo_auto, repo_usuario).vender_a_fiubak(patente_no_existente, propietario.id)
      end.to raise_error(ErrorAutoNoExiste)
    end

    xit 'deberia dar error si el auto no esta cotizado' do
      patente = 'NOC123'
      modelo = 'No Cotizado'
      anio = 1999
      kilometros = 4000
      creador_auto.crear_auto(patente, modelo, anio, kilometros, propietario.id)
      expect do
        described_class.new(repo_auto, repo_usuario).vender_a_fiubak(patente, propietario.id)
      end.to raise_error(ErrorAutoNoCotizado)
    end
  end
end
