require 'spec_helper'

describe 'Rechazado' do
  it 'deberia ser igual que otro Rechazado' do
    rechazado = Rechazado.new
    rechazado2 = Rechazado.new

    expect(rechazado).to eq rechazado2
  end
end
