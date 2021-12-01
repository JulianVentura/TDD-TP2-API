require 'spec_helper'

describe 'CreadorAuto' do
  let(:un_usuario) { Usuario.new('Juan', 123, 'juan@email.com') }
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
  
  context 'cuando existe un usuario' do

    it 'deberia crear un auto' do
      patente = 'AA752OH'
      modelo = 'Fiat'
      anio = 1999
      kilometros = 4000

      auto = instance_double(Auto)
      repo_auto = instance_double(Persistence::Repositories::RepositorioAuto)
      repo_usuario = instance_double(Persistence::Repositories::RepositorioUsuario)

      allow(Auto).to receive(:new).with(patente, modelo, anio, kilometros, un_usuario).and_return(auto)
      allow(repo_auto).to receive(:save).with(auto).and_return(auto)
      allow(repo_usuario).to receive(:existe_usuario).with(un_usuario.id).and_return(true)
      allow(repo_usuario).to receive(:find).with(un_usuario.id).and_return(un_usuario)
      
      CreadorAuto.new(repo_auto, repo_usuario).crear_auto(patente, modelo, anio, kilometros, un_usuario.id)
    end

    it 'deberia fallar si faltan argumentos' do
      patente = 'AA752OH'
      anio = 1999
      kilometros = 4000

      expect do
        creador_auto.crear_auto(patente, nil, anio, kilometros, un_usuario.id)
      end.to raise_error(ErrorFaltanArgumentos)
    end

  end

  context 'cuando no existe un usuario' do

    it 'deberia lanzar ErrorUsuarioInexistente' do
      patente = 'AA752OH'
      modelo = 'Fiat'
      anio = 1999
      kilometros = 4000

      auto = instance_double(Auto)
      repo_auto = instance_double(Persistence::Repositories::RepositorioAuto)
      repo_usuario = instance_double(Persistence::Repositories::RepositorioUsuario)

      allow(Auto).to receive(:new).with(patente, modelo, anio, kilometros, un_usuario).and_return(auto)
      allow(repo_auto).to receive(:save).with(auto).and_return(auto)
      allow(repo_usuario).to receive(:existe_usuario).with(un_usuario.id).and_return(false)
      allow(repo_usuario).to receive(:find).with(un_usuario.id).and_return(un_usuario)

      expect do
        CreadorAuto.new(repo_auto, repo_usuario).crear_auto(patente, modelo, anio, kilometros, un_usuario.id)
      end.to raise_error(ErrorUsuarioInexistente)
    end
  end
end
