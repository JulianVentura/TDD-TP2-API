require 'integration_helper'

describe Persistence::Repositories::RepositorioUsuario do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:id_usuario) { 123 }
  let(:un_usuario) { Usuario.new('Juan', id_usuario, 'juan@gmail.com') }

  it 'deberia almacenar un usuario nuevo' do
    repo_usuario.save(un_usuario)
    expect(repo_usuario.all.count).to eq(1)
  end

  context 'cuando existe un usuario' do
    before :each do
      @nuevo_usuario = repo_usuario.save(un_usuario)
      @id_usuario_tabla = @nuevo_usuario.id
    end

    it 'deberia tener el mismo id con el que se almaceno' do
      usuario_de_repo = repo_usuario.find(id_usuario)
      expect(usuario_de_repo.id).to eq(id_usuario)
    end
  end

end
