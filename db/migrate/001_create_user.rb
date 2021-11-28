Sequel.migration do
  up do
    create_table(:usuario) do
      primary_key :id
      String :nombre
      String :email
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:usuario)
  end
end
