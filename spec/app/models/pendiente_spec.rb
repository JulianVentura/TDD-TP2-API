require 'spec_helper'

describe 'Pendiente' do
  it 'deberia ser igual que otro Pendiente' do
    pendiente = Pendiente.new
    pendiente2 = Pendiente.new

    expect(pendiente).to eq pendiente2
  end

  it 'deberia estar pendiente' do
    pendiente = Pendiente.new

    expect(pendiente.pendiente?).to eq true
  end
end
