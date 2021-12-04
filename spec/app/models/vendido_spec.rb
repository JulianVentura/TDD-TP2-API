require 'spec_helper'

describe 'Vendido' do
  it 'deberia ser igual que otro Vendido' do
    vendido = Vendido.new
    vendido2 = Vendido.new

    expect(vendido).to eq vendido2
  end
end
