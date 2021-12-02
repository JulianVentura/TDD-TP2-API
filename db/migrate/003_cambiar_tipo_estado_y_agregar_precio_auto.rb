Sequel.migration do
  up do
    drop_column :auto, :estado
    add_column :auto, :estado, String, default: 'en_revision'
    add_column :auto, :precio, Integer, default: 0
  end

  down do
    drop_column :auto, :estado
    drop_column :auto, :precio
    add_column :auto, :estado, Integer
  end
end
