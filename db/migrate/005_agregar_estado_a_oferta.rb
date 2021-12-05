Sequel.migration do
  up do
    add_column :oferta, :estado, String, default: 'pendiente'
  end

  down do
    drop_column :oferta, :estado
  end
end
