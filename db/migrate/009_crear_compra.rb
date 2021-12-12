Sequel.migration do
  up do
    create_table(:compra) do
      primary_key :id
      foreign_key :id_comprador, :usuario
      foreign_key :id_vendedor, :usuario
      foreign_key :patente, :auto, type: String
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:compra)
  end
end
