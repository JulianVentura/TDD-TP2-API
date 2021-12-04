require 'spec_helper'

describe 'Vendido' do

  it 'deberia ser igual que otro Vendido' do
    vendido = Vendido.new
    vendido2 = Vendido.new

    expect(vendido).to eq vendido
  end

  it 'deberia estar en venta' do
    vendido = Vendido.new

    expect(vendido.en_venta?).to eq true
  end


end