require 'spec_helper'

describe ConsultadorOfertasRealizadas do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:repo_oferta) { Persistence::Repositories::RepositorioOferta.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:publicador_auto) { PublicadorP2P.new(repo_auto, repo_usuario) }
  let(:creador_ofertas) { CreadorOferta.new(repo_oferta, repo_auto, repo_usuario) }

  context 'Existen dos ofertas de un usuario' do
    let(:usuario) { creador_usuario.crear_usuario('jorge', 13_159, 'jorgito@gmail.com') }
    let(:propietario) { creador_usuario.crear_usuario('Juana', 13_232, 'juana@gmail.com') }

    before :each do
      repo_usuario.save(usuario)
      repo_usuario.save(propietario)
      crear_auto_publicado_p2p('ABC123', propietario, creador_auto, cotizador_auto, publicador_auto)
      crear_auto_publicado_p2p('ZXC123', propietario, creador_auto, cotizador_auto, publicador_auto)
      creador_ofertas.crear('ABC123', usuario.id, 5000)
      creador_ofertas.crear('ZXC123', usuario.id, 2000)
    end

    it 'lista las 2 ofertas del usuario' do
      patentes = %w[ABC123 ZXC123]
      ofertas = ConsultadorOfertasRealizadas.new(repo_oferta).consultar(usuario.id)

      expect(ofertas.size).to eq 2
      expect(patentes).to include ofertas[0].auto.patente
      expect(patentes).to include ofertas[1].auto.patente
    end
  end
end
