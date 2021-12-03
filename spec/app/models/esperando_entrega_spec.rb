require 'spec_helper'

describe 'EsperandoEntrega' do

  it 'deberia tener estado :esperando_entrega' do
    estado = EsperandoEntrega.new
    expect(estado.estado).to eq :esperando_entrega
  end

end
