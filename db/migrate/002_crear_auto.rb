Sequel.migration do
  up do
    create_table(:auto) do
      String :patente, primary_key: true
      foreign_key :id_usuario, :usuario
      String :modelo
      Integer :kilometros
      Integer :anio
      Integer :estado
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:auto)
  end
end
