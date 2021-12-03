require 'spec_helper'

describe EntregarLlaves do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
  let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
  let(:vendedor_auto) { VendedorAuto.new(repo_auto, repo_usuario) }

  context 'ya existe un auto vendido a fiubak' do
    let(:patente) { 'AA752OH' }
    let(:propietario) { creador_usuario.crear_usuario('Juan', 123, 'juan@email.com') }

    before :each do
      repo_usuario.save(Fiubak.new)
      modelo = 'Fiat'
      anio = 1999
      kilometros = 4000
      creador_auto.crear_auto(patente, modelo, anio, kilometros, propietario.id)

      precio = 12_000
      cotizador_auto.cotizar(patente, precio)

      vendedor_auto.vender_a_fiubak(patente, propietario.id)
    end

    it 'deberia cambiar de propietario a fiubak cuando se entregan las llaves' do
      auto_fiubak = described_class.new(repo_auto, repo_usuario).entregar_llaves(patente)
      expect(auto_fiubak.usuario.id).to eq Fiubak.new.id
    end

    context 'ya se entregaron las llaves del auto' do
      before :each do
        described_class.new(repo_auto, repo_usuario).entregar_llaves(patente)
      end

      it 'deberia dar error si intento entregar las llaves de nuevo' do
        expect do
          described_class.new(repo_auto, repo_usuario).entregar_llaves(patente)
        end.to raise_error(ErrorAutoNoEsperaEntregaLlaves)
      end
    end

  end
end
