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

  it 'deberia tener el mismo estado con el que se almaceno' do
    oferta = repo_oferta.save(una_oferta)
    oferta_recuperada = repo_oferta.find(oferta.id)
    expect(oferta_recuperada.estado).to eq Pendiente.new
  end

  context 'ya existe una oferta' do
    before :each do
      repo_oferta.save(una_oferta)
    end

    it 'existe_oferta_usuario_auto deberia devolver true si existe la oferta' do
      expect(repo_oferta.existe_oferta_usuario_auto(ofertante.id, auto.patente)).to eq true
    end

    it 'existe_oferta_usuario_auto deberia ser case insensitive para la patente' do
      patente_downcase = auto.patente.downcase
      expect(repo_oferta.existe_oferta_usuario_auto(ofertante.id, patente_downcase)).to eq true
    end

    it 'deberia existir esa oferta por id' do
      expect(repo_oferta.existe_oferta_id(una_oferta.id)).to eq true
    end

    it 'deberia buscar ofertas por patentes' do
      otro_oferante = CreadorUsuario.new(repo_usuario).crear_usuario('Jose', 34_537, 'jose@gmail.com')
      otra_oferta = Oferta.crear(auto, otro_oferante, 14_000)
      repo_oferta.save(otra_oferta)
      ids = [ofertante.id, otro_oferante.id]
      ofertas = repo_oferta.buscar_por_patente(una_oferta.auto.patente)
      expect(ofertas.size).to eq 2
      expect(ids).to include ofertas[0].ofertante.id
      expect(ids).to include ofertas[1].ofertante.id
    end

    it 'deberia buscar ofertas por usuario' do
      otro_auto = crear_auto_publicado_p2p('ZXC123', propietario, creador_auto, cotizador_auto, publicador)
      otra_oferta = Oferta.crear(otro_auto, ofertante, 15_000)
      repo_oferta.save(otra_oferta)
      patentes = %w[ZXC123 ABC123]
      ofertas = repo_oferta.buscar_por_ofertante(ofertante.id)
      expect(ofertas.size).to eq 2
      expect(patentes).to include ofertas[0].auto.patente
      expect(patentes).to include ofertas[1].auto.patente
    end

    it 'deberia buscar ofertas por patente y estado' do
      otro_oferante = CreadorUsuario.new(repo_usuario).crear_usuario('Jose', 34_537, 'jose@gmail.com')
      otra_oferta = Oferta.crear(auto, otro_oferante, 15_000)
      otra_oferta.rechazar
      repo_oferta.save(otra_oferta)
      ids = [ofertante.id, otro_oferante.id]
      ofertas = repo_oferta.buscar_por_patente_y_estado(auto.patente, Pendiente.new)
      expect(ofertas.size).to eq 1
      expect(ids).to include ofertas[0].ofertante.id
    end
  end
end
