Sequel.migration do
  up do
    set_column_type :auto, :id_usuario, :Bignum
  end

  down do
    set_column_type :auto, :id_usuario, Integer
  end
end
