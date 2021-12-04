require 'spec_helper'

describe 'Publicado' do
  it 'deberia ser igual que otro Publicado' do
    publicado = Publicado.new
    publicado2 = Publicado.new

    expect(publicado).to eq publicado2
  end

  it 'deberia estar publicado' do
    publicado = Publicado.new

    expect(publicado.esta_publicado?).to eq true
  end
end
