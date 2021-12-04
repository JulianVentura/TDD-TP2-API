require 'spec_helper'

describe Oferta do
  let(:ofertante) { Usuario.new('Juan', 34_535, 'juan@gmail.com') }
  let(:propietario) { Usuario.new('Jorge', 34_536, 'jorge@gmail.com') }
  let(:auto) { Auto.crear('AA752OH', 'Fiat', 40_000, 1999, propietario) }
  
  context 'cuando es creada' do
    it 'deberia ser valido cuando tiene todos los campos' do
      precio = 5000
      nueva_oferta = described_class.crear(auto, ofertante, precio)

      expect(nueva_oferta.auto.patente).to eq auto.patente
      expect(nueva_oferta.precio).to eq precio
      expect(nueva_oferta.ofertante.id).to eq ofertante.id
    end
  end
end
