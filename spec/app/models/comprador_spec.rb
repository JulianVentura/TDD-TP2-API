require 'spec_helper'

describe Comprador do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:vendedor_auto) { VendedorAuto.new(repo_auto, repo_usuario) }
  let(:entrega) {EntregarLlaves.new(repo_auto,repo_usuario)}
  let(:comprador) {described_class.new(repo_auto,repo_usuario)}

  context 'ya existe un auto publicado' do
    let(:patente) { 'AA752OH' }
    let(:propietario) { creador_usuario.crear_usuario('Juan', 123, 'juan@email.com') }

    before :each do
      crear_auto_publicado(patente, propietario, creador_auto, cotizador_auto, vendedor_auto, entrega)
    end

    it 'deberia cambiar estado a vendido' do
      usuario_comprador = creador_usuario.crear_usuario("Jorge",124,'jorge@email.com')
      auto = comprador.comprar(patente,124)
      expect(auto.estado).to eq Vendido.new
    end

    it 'deberia fallar si no existe el auto' do
        usuario_comprador = creador_usuario.crear_usuario("Jorge",124,'jorge@email.com')
        expect{
            comprador.comprar("NOE123",124)
        }.to raise_error(ErrorAutoNoExiste)
      end

  end
end