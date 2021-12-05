require 'spec_helper'

describe ConsultadorOfertasRecibidas do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:repo_oferta) { Persistence::Repositories::RepositorioOferta.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:publicador_auto) { PublicadorP2P.new(repo_auto, repo_usuario) }
  let(:creador_ofertas) { CreadorOferta.new(repo_oferta, repo_auto, repo_usuario) }

  context 'Existen tres ofertas a un auto particular' do
    let(:usuario1) { creador_usuario.crear_usuario('jorge', 13_159, 'jorgito@gmail.com') }
    let(:usuario2) { creador_usuario.crear_usuario('Juan', 13_230, 'juan@gmail.com') }
    let(:usuario3) { creador_usuario.crear_usuario('Jose', 13_231, 'jose@gmail.com') }
    let(:propietario) { creador_usuario.crear_usuario('Juana', 13_232, 'juana@gmail.com') }

    before :each do
      repo_usuario.save(usuario1)
      repo_usuario.save(usuario2)
      repo_usuario.save(usuario3)
      repo_usuario.save(propietario)
      crear_auto_publicado_p2p('ABC123', propietario, creador_auto, cotizador_auto, publicador_auto)
      creador_ofertas.crear('ABC123', usuario1.id, 5000)
      creador_ofertas.crear('ABC123', usuario2.id, 2000)
      creador_ofertas.crear('ABC123', usuario3.id, 3000)
    end

    it 'lista las ofertas de los 3 usuarios' do
      ids = [usuario1.id, usuario2.id, usuario3.id]
      ofertas = ConsultadorOfertasRecibidas.new(repo_oferta, repo_auto).consultar('ABC123', propietario.id)

      expect(ofertas.size).to eq 3
      expect(ids).to include ofertas[0].ofertante.id
      expect(ids).to include ofertas[1].ofertante.id
      expect(ids).to include ofertas[2].ofertante.id
    end

    it 'deberia fallar si no existe el auto' do
      expect  do
        ConsultadorOfertasRecibidas.new(repo_oferta, repo_auto).consultar('NOE123', propietario.id)
      end.to raise_error(ErrorAutoNoExiste)
    end

    it 'deberia fallar si el usuario no es el vendedor' do
      expect do
        ConsultadorOfertasRecibidas.new(repo_oferta, repo_auto).consultar('ABC123', usuario1.id)
      end.to raise_error(ErrorUsuarioNoEsElPropietario)
    end
  end
end
