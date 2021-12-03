require 'spec_helper'

describe Usuario do
  context 'cuando es creado' do
    it 'deberia ser valido cuando tiene todos los campos' do
      nuevo_usuario = described_class.new('juan', 1234, 'juan@gmail.com')
      expect(nuevo_usuario.nombre).to eq 'juan'
      expect(nuevo_usuario.id).to eq 1234
      expect(nuevo_usuario.email).to eq 'juan@gmail.com'
    end

    it 'es_particular? devuelve true' do
      nuevo_usuario = described_class.new('juan', 1234, 'juan@gmail.com')
      expect(nuevo_usuario.es_particular?).to eq true
    end
  end
end
