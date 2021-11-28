Sequel.migration do
  up do
    create_table(:usuario) do
      primary_key :id
      String :nombre
      Date :creado_en
      Date :actualizado_en
    end
  end

  down do
    drop_table(:usuario)
  end
end
