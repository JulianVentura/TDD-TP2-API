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

   it 'deberia traducir Cotizado a texto cotizado' do
     estado = Cotizado.new
     estado_texto = TraductorEstadoAuto.new.simbolo_a_texto(estado.estado)

     expect(estado_texto).to eq 'cotizado'
   end

   it 'deberia traducir EsperandoEntrega a texto esperando_entrega' do
     estado = EsperandoEntrega.new
     estado_texto = TraductorEstadoAuto.new.simbolo_a_texto(estado.estado)

     expect(estado_texto).to eq 'esperando_entrega'
   end

   it 'deberia traducir Publicado a texto publicado' do
     estado = Publicado.new
     estado_texto = TraductorEstadoAuto.new.simbolo_a_texto(estado.estado)

     expect(estado_texto).to eq 'publicado'
   end

   it 'deberia traducir Vendido a texto vendido' do
     estado = Vendido.new
     estado_texto = TraductorEstadoAuto.new.simbolo_a_texto(estado.estado)

     expect(estado_texto).to eq 'vendido'
   end

   it 'deberia dar error si texto estado no existe' do
     estado_texto = 'no_existe'
     expect do
       TraductorEstadoAuto.new.texto_a_estado(estado_texto)
     end.to raise_error(ErrorEstadoNoExiste)
   end

end
