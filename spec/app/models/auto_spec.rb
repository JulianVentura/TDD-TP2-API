require 'spec_helper'

describe Auto do
  let(:un_usuario) { Usuario.new('juan', 34_535, 'juan@gmail.com') }

  context 'cuando es creado' do
    it 'deberia ser valido cuando tiene todos los campos' do
      nuevo_auto = described_class.new('AA752OH', 'Fiat', 40_000, 1999, un_usuario)
      expect(nuevo_auto.patente).to eq 'AA752OH'
      expect(nuevo_auto.modelo).to eq 'Fiat'
      expect(nuevo_auto.kilometros).to eq 40_000
    end
  end

  context 'cuando ya esta creado' do
    it 'deberia actualizar su precio al cotizarse' do
      nuevo_auto = described_class.new('AA752OH', 'Fiat', 40_000, 1999, un_usuario)
      nuevo_auto.cotizar(10_000)
      expect(nuevo_auto.precio).to eq 10_000
    end
  end
end
