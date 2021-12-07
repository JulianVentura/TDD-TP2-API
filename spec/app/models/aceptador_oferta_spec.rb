require 'spec_helper'

describe AceptadorOferta do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:repo_oferta) { Persistence::Repositories::RepositorioOferta.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:publicador) { PublicadorP2P.new(repo_auto, repo_usuario) }
  let(:ofertante) { creador_usuario.crear_usuario('Jorge', 124, 'jorge@email.com') }

  context 'ya existe una oferta creada' do
    let(:patente) { 'AA752OH' }
    let(:propietario) { creador_usuario.crear_usuario('Juan', 123, 'juan@email.com') }
    let(:aceptador) { AceptadorOferta.new(repo_oferta, repo_auto) }

    before :each do
      creador_auto.crear_auto(patente, 'Fiat', 1990, 1000, propietario.id)
      cotizador_auto.cotizar(patente, 15_000)
      publicador.publicar_p2p(patente, propietario.id, 16_000)
      precio_ofertante = 13_000
      @oferta = CreadorOferta.new(repo_oferta, repo_auto, repo_usuario).crear(patente, ofertante.id, precio_ofertante)
    end

    it 'deberia aceptar una oferta correctamente' do
      oferta_aceptada = aceptador.aceptar(@oferta.id, propietario.id)
      estado_aceptado = Aceptado.new

      expect(oferta_aceptada.estado).to eq estado_aceptado
    end

    it 'deberia cambiar el estado del auto a vendido' do
      aceptador.aceptar(@oferta.id, propietario.id)

      auto = repo_auto.find(patente)

      expect(auto.estado).to eq Vendido.new
    end

    it 'deberia levantar error por oferta inexistente' do
      id_inexistente = 546_789_132

      expect do
        aceptador.aceptar(id_inexistente, propietario.id)
      end.to raise_error(ErrorOfertaNoExiste)
    end

    it 'deberia levantar error por usuario no coincidente' do
      id_usuario_invalido = 9576

      expect do
        aceptador.aceptar(@oferta.id, id_usuario_invalido)
      end.to raise_error(ErrorOfertaUsuarioNoCoincide)
    end
  end
end
