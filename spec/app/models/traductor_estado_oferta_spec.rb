require 'spec_helper'

describe 'TraductorEstadoOferta' do
   it 'deberia traducir "pendiente" a clase Pendiente' do
     estado_texto = 'pendiente'
     estado = TraductorEstadoOferta.new.texto_a_estado(estado_texto)

     expect(estado).to eq Pendiente
   end

   it 'deberia traducir "rechazado" a clase Rechazado' do
     estado_texto = 'rechazado'
     estado = TraductorEstadoOferta.new.texto_a_estado(estado_texto)

     expect(estado).to eq Rechazado
   end

   it 'deberia traducir "aceptado" a clase Aceptado' do
     estado_texto = 'aceptado'
     estado = TraductorEstadoOferta.new.texto_a_estado(estado_texto)

     expect(estado).to eq Aceptado
   end

   it 'deberia traducir Pendiente a texto pendiente' do
     estado = Pendiente.new
     estado_texto = TraductorEstadoOferta.new.simbolo_a_texto(estado.estado)

     expect(estado_texto).to eq 'pendiente'
   end
end
