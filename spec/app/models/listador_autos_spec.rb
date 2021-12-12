require 'spec_helper'

describe ListadorAutos do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:repo_compra) { Persistence::Repositories::RepositorioCompra.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:vendedor_auto) { VendedorAuto.new(repo_auto, repo_usuario, repo_compra) }
  let(:entrega_llaves) { EntregarLlaves.new(repo_auto, repo_usuario) }

  context 'Existen tres autos "Publicado" en Fiubak' do
    let(:un_usuario) { creador_usuario.crear_usuario('jorge', 13_159, 'jorgito@gmail.com') }
    let(:otro_usuario) { creador_usuario.crear_usuario('Juan', 13_230, 'juan@gmail.com') }

    before :each do
      repo_usuario.save(Fiubak.new)
      crear_auto_publicado('ABC123', un_usuario, creador_auto, cotizador_auto, vendedor_auto, entrega_llaves)
      crear_auto_publicado('ABC124', otro_usuario, creador_auto, cotizador_auto, vendedor_auto, entrega_llaves)
      crear_auto_cotizado('ABC125', un_usuario, creador_auto, cotizador_auto)
      crear_auto_publicado('JHK123', otro_usuario, creador_auto, cotizador_auto, vendedor_auto, entrega_llaves)
    end

    it 'listar_publicados deberia listar autos de patente "ABC123", "ABC124", "ABC125"' do
      patentes = %w[ABC123 ABC124 JHK123]
      autos = ListadorAutos.new(repo_auto).listar_publicado

      expect(autos.size).to eq 3
      expect(patentes).to include autos[0].patente
      expect(patentes).to include autos[1].patente
      expect(patentes).to include autos[2].patente
    end
  end
end
