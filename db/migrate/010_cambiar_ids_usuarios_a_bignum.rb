Sequel.migration do
  up do
    set_column_type :compra, :id_comprador, :Bignum
    set_column_type :compra, :id_vendedor, :Bignum
  end

  down do
    set_column_type :compra, :id_comprador, Integer
    set_column_type :compra, :id_vendedor, Integer
  end
end

