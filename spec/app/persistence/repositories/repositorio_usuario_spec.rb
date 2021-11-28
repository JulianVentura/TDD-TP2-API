require 'integration_helper'

describe Persistence::Repositories::RepositorioUsuario do
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:un_usuario) { Usuario.new('Juan', 123, 'juan@gmail.com') }

  it 'deberia almacenar un usuario nuevo' do
    repo_usuario.save(un_usuario)
    expect(repo_usuario.all.count).to eq(1)
  end

end
