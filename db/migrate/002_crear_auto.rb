Sequel.migration do
  up do
    create_table(:auto) do
      primary_key :id
      String :patente
      String :modelo
      Integer :kilometros
      String :anio
      Integer :estado
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:auto)
  end
end
