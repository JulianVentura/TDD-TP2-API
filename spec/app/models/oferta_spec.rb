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

    it 'deberia tener estado pendiente' do
      precio = 3000
      nueva_oferta = described_class.crear(auto, ofertante, precio)
      estado_pendiente = Pendiente.new

      expect(nueva_oferta.estado).to eq estado_pendiente
    end

    it 'desde el repo, deberia tener un id' do
      precio = 3000
      id = 123
      nueva_oferta = described_class.crear_desde_repo(auto, ofertante, precio, id)

      expect(nueva_oferta.auto.patente).to eq auto.patente
      expect(nueva_oferta.precio).to eq precio
      expect(nueva_oferta.ofertante.id).to eq ofertante.id
      expect(nueva_oferta.id).to eq id
    end

    it 'deberia lanzar error si el auto no esta "Publicado"' do
      precio = 5000
      auto_no_publicado = Auto.crear('AA752OH', 'Fiat', 40_000, 1999, propietario)

      expect do
        described_class.crear(auto_no_publicado, ofertante, precio)
      end.to raise_error(ErrorAutoNoEstaPublicado)
    end

    it 'deberia lanzar error si el precio no es positivo' do
      precio = -100
      expect do
        described_class.crear(auto, ofertante, precio)
      end.to raise_error(ErrorOfertaInvalida)
    end

    it 'deberia lanzar error si el precio es nil' do
      precio = nil
      expect do
        described_class.crear(auto, ofertante, precio)
      end.to raise_error(ErrorOfertaInvalida)
    end
  end
end
