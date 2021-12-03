require 'spec_helper'

describe Auto do
  let(:un_usuario) { Usuario.new('juan', 34_535, 'juan@gmail.com') }

  context 'cuando es creado' do
    it 'deberia ser valido cuando tiene todos los campos' do
      nuevo_auto = described_class.crear('AA752OH', 'Fiat', 40_000, 1999, un_usuario)
      expect(nuevo_auto.patente).to eq 'AA752OH'
      expect(nuevo_auto.modelo).to eq 'Fiat'
      expect(nuevo_auto.kilometros).to eq 40_000
    end
  end

  context 'cuando ya esta creado' do
    it 'deberia actualizar su precio al cotizarse' do
      nuevo_auto = described_class.crear('AA752OH', 'Fiat', 40_000, 1999, un_usuario)
      nuevo_auto.cotizar(10_000)
      expect(nuevo_auto.precio).to eq 10_000
    end

    it 'deberia actualizar su estado al venderse a fiubak' do
      # TODO: validar que este cotizado
      nuevo_auto = described_class.crear('AA752OH', 'Fiat', 40_000, 1999, un_usuario)
      nuevo_auto.vender_a_fiubak

      estado_esperado = EsperandoEntrega.new
      expect(nuevo_auto.estado).to eq estado_esperado
    end

    it 'deberia tener propietario distinto al cambiar por un propietario diferente al anterior' do
      nuevo_auto = described_class.crear('AA752OH', 'Fiat', 40_000, 1999, un_usuario)
      otro_usuario = Usuario.new('otro', 12_535, 'juan@gmail.com')
      nuevo_auto.cambiar_de_propietario(otro_usuario)

      expect(nuevo_auto.usuario).to eq otro_usuario
    end

    context 'cuando esta cotizado' do
      let(:un_auto) { described_class.crear('AA752OH', 'Fiat', 40_000, 1999, un_usuario) }
      let(:precio) { 10_000 }

      before :each do
        un_auto.cotizar(precio)
      end

      context 'cuando se vende a fiubak' do
        before :each do
          un_auto.vender_a_fiubak
        end

        it 'deberia multiplicar su precio por la tasa y el estado cambiar a "Publicado" al publicarse' do
          tasa = 20
          un_auto.publicar(tasa)

          expect(un_auto.precio).to eq precio * (100 + tasa) / 100
          expect(un_auto.estado).to eq Publicado.new
        end
      end

      context 'cuando se publica p2p' do
        it 'deberia cambiar su estado a "Pendiente" y su precio segun lo pasado por parametro' do
          precio_p2p = 5000
          un_auto.publicar_p2p(precio_p2p)

          expect(un_auto.precio).to eq precio_p2p
          expect(un_auto.estado).to eq Publicado.new
        end
      end
    end
  end
end
