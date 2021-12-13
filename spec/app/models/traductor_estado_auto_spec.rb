require 'spec_helper'

describe 'TraductorEstadoAuto' do
   it 'deberia traducir "en_revision" a clase EnRevision' do
     estado_texto = 'en_revision'
     estado = TraductorEstadoAuto.new.texto_a_estado(estado_texto)

     expect(estado).to eq EnRevision
   end

   it 'deberia traducir "cotizado" a clase Cotizado' do
     estado_texto = 'cotizado'
     estado = TraductorEstadoAuto.new.texto_a_estado(estado_texto)

     expect(estado).to eq Cotizado
   end

   it 'deberia traducir "esperando_entrega" a clase EsperandoEntrega' do
     estado_texto = 'esperando_entrega'
     estado = TraductorEstadoAuto.new.texto_a_estado(estado_texto)

     expect(estado).to eq EsperandoEntrega
   end

   it 'deberia traducir "publicado" a clase Publicado' do
     estado_texto = 'publicado'
     estado = TraductorEstadoAuto.new.texto_a_estado(estado_texto)

     expect(estado).to eq Publicado
   end

   it 'deberia traducir "vendido" a clase Vendido' do
     estado_texto = 'vendido'
     estado = TraductorEstadoAuto.new.texto_a_estado(estado_texto)

     expect(estado).to eq Vendido
   end

   it 'deberia traducir EnRevision a texto en_revision' do
     estado = EnRevision.new
     estado_texto = TraductorEstadoAuto.new.simbolo_a_texto(estado.estado)

     expect(estado_texto).to eq 'en_revision'
   end
end
