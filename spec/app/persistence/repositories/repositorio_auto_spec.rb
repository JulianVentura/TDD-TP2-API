require 'integration_helper'

describe Persistence::Repositories::RepositorioAuto do
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:patente) { 'AA752OH' }
  let(:repo_usuario) { Persistence::Repositories::RepositorioUsuario.new }
  let(:un_usuario) { Usuario.new('juan', 34_535, 'juan@gmail.com') }
  let(:un_auto) { Auto.crear(patente, 'Fiat', 40_000, 1999, un_usuario) }

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

    it 'deberia tener los mismo atributos por defecto con los que se almaceno' do
      repo_auto.save(un_auto)
      auto_de_repo = repo_auto.find(patente)
      expect(auto_de_repo.precio).to eq(0)
      expect(auto_de_repo.estado).to eq(EnRevision.new)
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

    it 'find por patente deberia ser case insensitive' do
      patente_downcase = @patente_utilizada.downcase
      auto_de_repo = repo_auto.find(patente_downcase)
      expect(auto_de_repo.patente).to eq(patente)
    end

    it 'existe_auto por patente deberia ser case insensitive' do
      patente_downcase = @patente_utilizada.downcase
      expect(repo_auto.existe_auto(patente_downcase)).to eq true
    end
  end

  context 'cuando un usuario tiene registrado 3 autos' do
    let(:otro_usuario) { Usuario.new('jorge', 13_159, 'jorgito@gmail.com') }

    before :each do
      auto1 = Auto.crear('ABC123', 'Fiat', 40_000, 1999, un_usuario)
      auto2 = Auto.crear('ABC124', 'Ford', 3500, 2005, un_usuario)
      auto3 = Auto.crear('ABC125', 'Chevrolet', 1000, 2019, otro_usuario)
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

  context 'cuando hay 2 autos con estado "Publicado" y uno "Cotizado"' do
    let(:otro_usuario) { Usuario.new('jorge', 13_159, 'jorgito@gmail.com') }
    let(:creador_auto) { CreadorAuto.new(repo_auto, repo_usuario) }
    let(:cotizador_auto) { CotizadorAuto.new(repo_auto) }
    let(:vendedor_auto) { VendedorAuto.new(repo_auto, repo_usuario) }
    let(:entrega_llaves) { EntregarLlaves.new(repo_auto, repo_usuario) }

    before :each do
      repo_usuario.save(Fiubak.new)
      repo_usuario.save(un_usuario)
      repo_usuario.save(otro_usuario)
      crear_auto_publicado('ABC123', un_usuario, creador_auto, cotizador_auto, vendedor_auto, entrega_llaves)
      crear_auto_publicado('ABC124', otro_usuario, creador_auto, cotizador_auto, vendedor_auto, entrega_llaves)
      crear_auto_cotizado('ABC125', un_usuario, creador_auto, cotizador_auto)
    end

    it 'por_estado publicado deberia retornar 2 autos' do
      autos = repo_auto.por_estado(Publicado.new)
      patentes = %w[ABC123 ABC124]

      expect(autos.size).to eq 2
      expect(patentes).to include autos[0].patente
      expect(patentes).to include autos[1].patente
    end
  end
end
