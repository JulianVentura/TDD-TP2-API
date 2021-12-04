require 'spec_helper'

describe CreadorOferta do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:repo_oferta) { Persistence::Repositories::RepositorioOferta.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:publicador) { PublicadorP2P.new(repo_auto, repo_usuario) }
  let(:ofertante) { creador_usuario.crear_usuario('Jorge', 124, 'jorge@email.com') }


  context 'ya existe un auto publicado p2p' do
    let(:patente) { 'AA752OH' }
    let(:propietario) { creador_usuario.crear_usuario('Juan', 123, 'juan@email.com') }

    before :each do
      creador_auto.crear_auto(patente, 'Fiat', 1990, 1000, propietario.id)
      cotizador_auto.cotizar(patente, 15_000)
      publicador.publicar_p2p(patente, propietario.id, 16_000)
    end

    it('se deberia realizar una oferta correctamente') do
      precio_ofertante = 13_000
      oferta = CreadorOferta.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)

      expect(oferta.auto.patente).to eq patente
      expect(oferta.precio).to eq precio_ofertante
      expect(oferta.ofertante.id).to eq ofertante.id
    end

    it 'deberia fallar si no existe el usuario' do
      expect do
        described_class.new(repo_oferta, repo_auto, repo_usuario).crear(patente, 5678, 400)
      end.to raise_error(ErrorUsuarioInexistente)
    end
  end

  it('deberia lanzar error si no existe el auto a ofertar') do
    precio_ofertante = 13_000
    patente = "ZZX123"
    
    expect do
      CreadorOferta.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)
    end.to raise_error(ErrorAutoNoExiste)
  end
end
