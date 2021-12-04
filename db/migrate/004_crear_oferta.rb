Sequel.migration do
  up do
    create_table(:oferta) do
      primary_key :id
      foreign_key :patente, :auto, type: String
      Integer :precio
      foreign_key :id_ofertante, :usuario
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:oferta)
  end
end
