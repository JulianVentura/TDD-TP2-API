require 'integration_helper'

describe Persistence::Repositories::RepositorioAuto do
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:patente) { 'AA752OH' }

  let(:un_auto) { Auto.new(patente, 'Fiat', 40_000, 1999, un_usuario) }

  context 'ya existe un usuario' do
    let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
    let(:un_usuario) { Usuario.new('juan', 34535, 'juan@gmail.com') }

    before :each do
      repo_usuario.save(un_usuario)
    end

    it 'deberia almacenar un auto nuevo' do
      repo_auto.save(un_auto)
      expect(repo_auto.all.count).to eq(1)
    end
  end

end
