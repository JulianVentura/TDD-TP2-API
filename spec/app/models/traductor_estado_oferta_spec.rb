require 'spec_helper'

describe 'TraductorEstadoOferta' do
   it 'deberia traducir "pendiente" a clase Pendiente' do
     estado_texto = 'pendiente'
     estado = TraductorEstadoOferta.new.texto_a_estado(estado_texto)

     expect(estado).to eq Pendiente
   end
end
