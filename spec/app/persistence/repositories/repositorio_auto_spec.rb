require 'integration_helper'

describe Persistence::Repositories::RepositorioAuto do
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:patente) { 'AA752OH' }
  let(:modelo) { 'Fiat' }

  context 'cuando existe un usuario' do
    let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
    let(:un_usuario) { Usuario.new('juan', 34535, 'juan@gmail.com') }
    let(:un_auto) { Auto.new(patente, 'Fiat', 40_000, 1999, un_usuario) }

    before :each do
      repo_usuario.save(un_usuario)
    end

    it 'deberia almacenar un auto nuevo' do
      repo_auto.save(un_auto)
      expect(repo_auto.all.count).to eq(1)
    end

    it 'deberia tener la misma patente con la que se almaceno' do
      repo_auto.save(un_auto)
      auto_de_repo =  repo_auto.find(patente)
      expect(auto_de_repo.patente).to eq(patente)
    end

    it 'deberia tener los mismo atributos con los que se almaceno' do
      repo_auto.save(un_auto)
      auto_de_repo = repo_auto.find(patente)
      expect(auto_de_repo.modelo).to eq('Fiat')
      expect(auto_de_repo.kilometros).to eq(40000)
      expect(auto_de_repo.anio).to eq(1999)
    end

    it 'deberia tener al mismo usuario con el que se almaceno' do
      repo_auto.save(un_auto)
      auto_de_repo = repo_auto.find(patente)
      expect(auto_de_repo.usuario.id).to eq(34535)
    end

  end

end
