require 'integration_helper'

describe Persistence::Repositories::RepositorioAuto do
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:patente) { 'AA752OH' }
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:un_usuario) { Usuario.new('juan', 34_535, 'juan@gmail.com') }
  let(:un_auto) { Auto.new(patente, 'Fiat', 40_000, 1999, un_usuario) }

  context 'cuando existe un usuario' do
    let(:modelo) { 'Fiat' }

    before :each do
      repo_usuario.save(un_usuario)
    end

    it 'deberia almacenar un auto nuevo' do
      repo_auto.save(un_auto)
      expect(repo_auto.all.count).to eq(1)
    end

    it 'deberia tener la misma patente con la que se almaceno' do
      repo_auto.save(un_auto)
      auto_de_repo = repo_auto.find(patente)
      expect(auto_de_repo.patente).to eq(patente)
    end

    it 'deberia tener los mismo atributos con los que se almaceno' do
      repo_auto.save(un_auto)
      auto_de_repo = repo_auto.find(patente)
      expect(auto_de_repo.modelo).to eq('Fiat')
      expect(auto_de_repo.kilometros).to eq(40_000)
      expect(auto_de_repo.anio).to eq(1999)
    end

    it 'deberia tener al mismo usuario con el que se almaceno' do
      repo_auto.save(un_auto)
      auto_de_repo = repo_auto.find(patente)
      expect(auto_de_repo.usuario.id).to eq(34_535)
    end
  end

  context 'cuando existe un auto' do
    before :each do
      repo_usuario.save(un_usuario)
      @nuevo_auto = repo_auto.save(un_auto)
      @patente_utilizada = un_auto.patente
    end

    it 'deberia existir esa patente' do
      expect(repo_auto.existe_auto(@patente_utilizada)).to eq true
    end
  end

  context 'cuando un usuario tiene registrado 3 autos' do
    let(:otro_usuario) { Usuario.new('jorge', 13_159, 'jorgito@gmail.com') }

    before :each do
      auto1 = Auto.new('ABC123', 'Fiat', 40_000, 1999, un_usuario)
      auto2 = Auto.new('ABC124', 'Ford', 3500, 2005, un_usuario)
      auto3 = Auto.new('ABC125', 'Chevrolet', 1000, 2019, otro_usuario)
      repo_usuario.save(un_usuario)
      repo_usuario.save(otro_usuario)
      repo_auto.save(auto1)
      repo_auto.save(auto2)
      repo_auto.save(auto3)
    end

    it 'debería devolver los autos de juan y no los de jorge' do
      autos = repo_auto.por_propietario(un_usuario.id)
      patentes = %w[ABC123 ABC124]

      expect(autos.size).to eq 2
      expect(patentes).to include autos[0].patente
      expect(patentes).to include autos[1].patente
    end
  end
end
