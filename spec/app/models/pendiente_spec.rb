require 'spec_helper'

describe 'Pendiente' do
  it 'deberia ser igual que otro Pendiente' do
    publicado = Pendiente.new
    publicado2 = Pendiente.new

    expect(publicado).to eq publicado2
  end
end

