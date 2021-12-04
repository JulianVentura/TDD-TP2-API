require 'spec_helper'

describe Oferta do
  let(:ofertante) { Usuario.new('Juan', 34_535, 'juan@gmail.com') }
  let(:propietario) { Usuario.new('Jorge', 34_536, 'jorge@gmail.com') }
  let(:auto) { Auto.crear('AA752OH', 'Fiat', 40_000, 1999, propietario) }
  
  before :each do
    auto.cotizar 4000
    auto.publicar_p2p 5000
  end

  context 'cuando es creada' do
    it 'deberia ser valido cuando tiene todos los campos' do
      precio = 3000
      nueva_oferta = described_class.crear(auto, ofertante, precio)

      expect(nueva_oferta.auto.patente).to eq auto.patente
      expect(nueva_oferta.precio).to eq precio
      expect(nueva_oferta.ofertante.id).to eq ofertante.id
    end

    it 'deberia lanzar error si el auto no esta "Publicado"' do
      precio = 5000
      auto_no_publicado = Auto.crear('AA752OH', 'Fiat', 40_000, 1999, propietario)

      expect {
        described_class.crear(auto_no_publicado, ofertante, precio)
      }.to raise_error(ErrorAutoNoEstaPublicado)
    end
  end
end
