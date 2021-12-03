require 'spec_helper'

describe PublicadorP2P do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:vendedor_auto) { VendedorAuto.new(repo_auto, repo_usuario) }

  context 'ya existe un auto vendido a fiubak' do
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

    it 'deberia cambiar su estado a "Pendiente" y su precio cuando se publica p2p' do
      precio_p2p = 15_000
      auto_fiubak = described_class.new(repo_auto, repo_usuario).publicar_p2p(patente, propietario.id, precio_p2p)
      expect(auto_fiubak.estado).to eq Publicado.new
      expect(auto_fiubak.precio).to eq precio_p2p
    end

    it 'deberia fallar si faltan argumentos' do
      expect do
        described_class.new(repo_auto, repo_usuario).publicar_p2p(patente, propietario.id, nil)
      end.to raise_error(ErrorFaltanArgumentos)
    end

    it 'deberia fallar si el auto no existe' do
      patente_inexistente = 'INV999'
      precio_p2p = 12_000

      expect do
        described_class.new(repo_auto, repo_usuario).publicar_p2p(patente_inexistente, propietario.id, precio_p2p)
      end.to raise_error(ErrorAutoNoExiste)
    end

    it 'deberia fallar si el auto no esta cotizado' do
      modelo = 'Fiat'
      anio = 1999
      kilometros = 4000
      patente = 'COT123'
      creador_auto.crear_auto(patente, modelo, anio, kilometros, propietario.id)
      precio_p2p = 1000

      expect do
        described_class.new(repo_auto, repo_usuario).publicar_p2p(patente, propietario.id, precio_p2p)
      end.to raise_error(ErrorAutoNoCotizado)
    end
  end
end
