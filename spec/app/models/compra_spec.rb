require 'spec_helper'

describe Compra do
  let(:comprador) { Usuario.new('juan', 34_535, 'juan@gmail.com') }
  let(:vendedor) { Usuario.new('jorge', 34_536, 'jorge@gmail.com') }
  let(:un_auto) { Auto.crear('AA752OH', 'Fiat', 40_000, 1999, vendedor) }

  it 'deberia crearse de manera valida cuando tiene todos los campos' do
    compra = Compra.new(comprador, vendedor, un_auto)
    expect(compra.comprador.id).to eq comprador.id
    expect(compra.vendedor.id).to eq vendedor.id
    expect(compra.auto.patente).to eq un_auto.patente
  end
end
