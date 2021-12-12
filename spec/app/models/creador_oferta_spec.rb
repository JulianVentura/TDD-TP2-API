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

    it('deberia crearse exitosamente si la primera fue rechazada') do
      precio_ofertante = 13_000

      oferta = described_class.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)
      RechazadorOferta.new(repo_oferta).rechazar(oferta.id, propietario.id)
      segunda_oferta = described_class.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)

      expect(segunda_oferta.auto.patente).to eq patente
      expect(segunda_oferta.precio).to eq precio_ofertante
      expect(segunda_oferta.ofertante.id).to eq ofertante.id
    end

    it('deberia fallar si se realiza una segunda oferta') do
      precio_ofertante = 13_000
      described_class.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)
      expect do
        described_class.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)
      end.to raise_error(ErrorYaSeRealizoOferta)
    end

    it('deberia lanzar error si el propietario intenta ofertar el auto') do
      precio_ofertante = 13_000
      expect do
        CreadorOferta.new(repo_oferta, repo_auto, repo_usuario).crear(patente, propietario.id, precio_ofertante)
      end.to raise_error(ErrorPropietarioRealizaOferta)
    end
  end

  it('deberia lanzar error si no existe el auto a ofertar') do
    precio_ofertante = 13_000
    patente = 'ZZX123'

    expect do
      CreadorOferta.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)
    end.to raise_error(ErrorAutoNoExiste)
  end

  context 'ya existe un auto publicado por fiubak' do
    let(:patente_fiubak) { 'AB333BH' }
    let(:ex_propietario) { creador_usuario.crear_usuario('Pedro', 455, 'pedro@email.com') }
    let(:repo_compra) { Persistence::Repositories::RepositorioCompra.new }
    let(:vendedor_auto) { VendedorAuto.new(repo_auto, repo_usuario, repo_compra) }
    let(:entregar_llaves) { EntregarLlaves.new(repo_auto, repo_usuario) }

    before :each do
      creador_auto.crear_auto(patente_fiubak, 'Fiat', 1990, 1000, ex_propietario.id)
      cotizador_auto.cotizar(patente_fiubak, 15_000)
      vendedor_auto.vender_a_fiubak(patente_fiubak, ex_propietario.id)
      entregar_llaves.entregar_llaves(patente_fiubak)
    end

    it('deberia lanzar error si le realizan una oferta') do
      precio_ofertante = 13_000

      expect do
        described_class.new(repo_oferta, repo_auto, repo_usuario).crear(patente_fiubak, ofertante.id, precio_ofertante)
      end.to raise_error(ErrorOfertaEnAutoNoParticular)
    end
  end
end
