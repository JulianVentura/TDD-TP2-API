require 'spec_helper'

describe 'CreadorAuto' do
  let(:repo_auto) { Persistence::Repositories::RepositorioAuto.new }
  let(:creado_auto) { CreadorAuto.new(repo_auto) }

  xit 'deberia crear un auto y almacenarlo' do
    patente = 'AA752OH'
    modelo = 'Fiat'
    anio = 1999
    kilometros = 4000

    auto = instance_double(Auto)
    repo_auto = instance_double(Persistence::Repositories::RepositorioAuto)

    allow(auto).to receive(:new).with(patente, modelo, anio, kilometros).and_return(auto)
    allow(repo_auto).to receive(:save).with(auto).and_return(auto)
    # allow(repo_auto).to receive(:existe_auto).with(patente).and_return(false)
    # allow(repo_auto).to receive(:existe_email).with(email).and_return(false)

    CreadorAuto.new(repo_auto).crear_auto(patente, modelo, anio, kilometros)
  end

end
