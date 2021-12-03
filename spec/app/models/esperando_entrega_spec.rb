require 'spec_helper'

describe EsperandoEntrega do
  it 'deberia tener estado :esperando_entrega' do
    esperando_entrega = described_class.new
    expect(esperando_entrega.estado).to eq :esperando_entrega
  end

  it 'deberia ser igual que otro Cotizado' do
    otro_esperando_entrega = EsperandoEntrega.new
    esperando_entrega = described_class.new
    expect(esperando_entrega).to eq otro_esperando_entrega
  end
end
