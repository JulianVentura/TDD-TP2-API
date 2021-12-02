require 'spec_helper'

describe 'Cotizado' do
  it 'deberia lanzar error al cotizar' do
    cotizado = Cotizado.new

    expect{
      cotizado.cotizar(100)
    }.to raise_error(ErrorNoCotizable)
  end
end
