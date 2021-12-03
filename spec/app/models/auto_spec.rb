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
  end
end
