require 'integration_helper'

describe Persistence::Repositories::RepositorioOferta do
  let(:repo_oferta) { Persistence::Repositories::RepositorioOferta.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:ofertante) { CreadorUsuario.new(repo_usuario).crear_usuario('Juan', 34_535, 'juan@gmail.com') }
  let(:propietario) { CreadorUsuario.new(repo_usuario).crear_usuario('Jorge', 34_536, 'jorge@gmail.com') }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:publicador) { PublicadorP2P.new(repo_auto, repo_usuario) }
  let(:auto) { crear_auto_publicado_p2p('ABC123', propietario, creador_auto, cotizador_auto, publicador) }
  let(:una_oferta) { Oferta.crear(auto, ofertante, 15_000) }

  it 'deberia almacenar una oferta nueva' do
    repo_oferta.save(una_oferta)
    expect(repo_oferta.all.count).to eq(1)
  end

  it 'deberia tener los mismos atributos con los que se almaceno' do
    oferta = repo_oferta.save(una_oferta)
    oferta_recuperada = repo_oferta.find(oferta.id)
    expect(oferta_recuperada.auto.patente).to eq una_oferta.auto.patente
    expect(oferta_recuperada.ofertante.id).to eq ofertante.id
    expect(oferta_recuperada.precio).to eq 15_000
  end

  context 'ya existe una oferta' do
    before :each do
      repo_oferta.save(una_oferta)
    end

    it 'existe_oferta_usuario_auto deberia devolver true si existe la oferta' do
      expect(repo_oferta.existe_oferta_usuario_auto(ofertante.id, auto.patente)).to eq true
    end
  end
end
