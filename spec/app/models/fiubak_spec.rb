require 'spec_helper'

describe Fiubak do
  context 'cuando es creado' do
    it 'deberia tener id 0' do
      nuevo_usuario = described_class.new
      expect(nuevo_usuario.id).to eq 0
    end

    it 'es_particular? devuelve false' do
      nuevo_usuario = described_class.new
      expect(nuevo_usuario.es_particular?).to eq false
    end

  end
end
