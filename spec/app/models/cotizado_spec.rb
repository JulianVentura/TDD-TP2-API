require 'spec_helper'

describe 'Cotizado' do
  it 'deberia lanzar error al cotizar' do
    cotizado = Cotizado.new

    expect  do
      cotizado.cotizar(100)
    end.to raise_error(ErrorNoCotizable)
  end
end
