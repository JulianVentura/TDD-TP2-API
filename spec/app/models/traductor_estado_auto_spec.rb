require 'spec_helper'

describe 'TraductorEstadoAuto' do
   it 'deberia traducir "en_revision" a clase EnRevision' do
     estado_texto = 'en_revision'
     estado = TraductorEstadoAuto.new.texto_a_estado(estado_texto)

     expect(estado).to eq EnRevision
   end

   it 'deberia traducir EnRevision a texto en_revision' do
     estado = EnRevision.new
     estado_texto = TraductorEstadoAuto.new.simbolo_a_texto(estado.estado)

     expect(estado_texto).to eq 'en_revision'
   end
end
