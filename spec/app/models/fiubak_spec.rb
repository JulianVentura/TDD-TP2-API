require 'spec_helper'

describe Fiubak do
  context 'cuando es creado' do
    it 'deberia tener id 0' do
      nuevo_usuario = described_class.new
      expect(nuevo_usuario.id).to eq 0
    end
  end
end
