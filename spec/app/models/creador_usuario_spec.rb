require 'spec_helper'

describe 'CreadorUsuario' do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }

  it 'deberia crear un usuario y almacenarlo' do
    nombre = 'juan'
    id = 123
    email = 'juan@gmail.com'
    usuario = instance_double(Usuario)
    repo_usuario = instance_double(Persistence::Repositories::RepositorioUsuario)

    allow(Usuario).to receive(:new).with(nombre, id, email).and_return(usuario)
    allow(repo_usuario).to receive(:save).with(usuario).and_return(usuario)
    allow(repo_usuario).to receive(:existe_usuario).with(id).and_return(false)
    allow(repo_usuario).to receive(:existe_email).with(email).and_return(false)

    CreadorUsuario.new(repo_usuario).crear_usuario('juan', 123, 'juan@gmail.com')
  end

  context 'ya existe un usuario' do
    let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
    let(:creador_usuario) { CreadorUsuario.new(repo_usuario) }
    let(:id_usuario) { 123 }
    let(:email) { 'juan@test.com' }

    before :each do
      creador_usuario.crear_usuario('juan', id_usuario, email)
    end

    it 'deberia fallar al crear un usuario con el mismo id' do
      expect do
        creador_usuario.crear_usuario('jorge', id_usuario, 'jorge@test.com')
      end.to raise_error(ErrorIdRepetido)
    end

    it 'deberia fallar al crear un usuario con el mismo email' do
      expect do
        creador_usuario.crear_usuario('jorge', 321, email)
      end.to raise_error(ErrorEmailRepetido)
    end
  end
end
