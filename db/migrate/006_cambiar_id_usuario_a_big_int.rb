Sequel.migration do
  up do
    set_column_type :usuario, :id, :Bignum
  end    

  down do
    set_column_type :usuario, :id, Integer
  end
end
