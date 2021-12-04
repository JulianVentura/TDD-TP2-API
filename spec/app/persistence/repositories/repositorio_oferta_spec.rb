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
end
