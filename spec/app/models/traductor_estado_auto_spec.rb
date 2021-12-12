require 'spec_helper'

describe 'TraductorEstadoAuto' do
   it 'deberia traducir "en_revision" a clase EnRevision' do
     estado_texto = 'en_revision'
     estado = TraductorEstadoAuto.new.crear(estado_texto)

     expect(estado).to eq EnRevision
  end
end
