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
      estado = Pendiente.new
      nueva_oferta = described_class.crear_desde_repo(auto, ofertante, precio, id, estado)

      expect(nueva_oferta.auto.patente).to eq auto.patente
      expect(nueva_oferta.precio).to eq precio
      expect(nueva_oferta.ofertante.id).to eq ofertante.id
      expect(nueva_oferta.id).to eq id
      expect(nueva_oferta.estado).to eq estado
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

    it 'deberia devolver id propietario' do
      precio = 3000
      nueva_oferta = described_class.crear(auto, ofertante, precio)

      expect(nueva_oferta.obtener_id_propietario).to eq propietario.id
    end
  end

  context 'cuando es rechazada' do
    it 'deberia cambiar estado pendiente a rechazada' do
      precio = 3000
      oferta = described_class.crear(auto, ofertante, precio)
      oferta.rechazar
      estado_rechazado = Rechazado.new

      expect(oferta.estado).to eq estado_rechazado
    end
  end

  context 'cuando es aceptada' do
    it 'deberia cambiar estado pendiente a aceptado' do
      precio = 3000
      oferta = described_class.crear(auto, ofertante, precio)
      oferta.aceptar
      estado_aceptado = Aceptado.new

      expect(oferta.estado).to eq estado_aceptado
    end

    it 'deberia lanzar error si el estado no es pendiente al aceptar' do
      precio = 3000
      oferta = described_class.crear(auto, ofertante, precio)
      oferta.aceptar
      
      expect do
        oferta.aceptar
      end.to raise_error(ErrorOfertaNoPendiente)
    end
  end
end
