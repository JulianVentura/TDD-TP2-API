require 'spec_helper'

describe 'Aceptado' do
  it 'deberia ser igual que otro Aceptado' do
    aceptado1 = Aceptado.new
    aceptado2 = Aceptado.new

    expect(aceptado1).to eq aceptado2
  end

  it 'deberia no estar pendiente' do
    aceptado1 = Aceptado.new

    expect(aceptado1.pendiente?).to eq false
  end
end
