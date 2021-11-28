require 'spec_helper'

describe 'CreadorUsuario' do
  it 'deberia crear un usuario y almacenarlo' do
    nombre = 'juan'
    id = 123
    email = 'juan@gmail.com'
    usuario = instance_double(Usuario)
    repo_usuario = instance_double(Persistence::Repositories::RepositorioUsuario)

    expect(Usuario).to receive(:new).with(nombre, id, email).and_return(usuario)
    expect(repo_usuario).to receive(:save).with(usuario).and_return(usuario)

    CreadorUsuario.new(repo_usuario).crear_usuario('juan', 123, 'juan@gmail.com')
  end
end
