Sequel.migration do
  up do
    set_column_type :oferta, :id_ofertante, :Bignum
  end

  down do
    set_column_type :oferta, :id_ofertante, Integer
  end
end
