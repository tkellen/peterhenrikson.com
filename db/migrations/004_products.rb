Sequel.migration do
  up do
    create_table(:product) do
      primary_key :id
      column :title, String, {:null=>false}
      column :description, String
      column :url_slug, String, {:null=>false}
      column :price, BigDecimal
      column :published, TrueClass, {:null=>false,:default=>true}
    end
    create_table(:product_photo) do
      primary_key :id
      foreign_key :product_id, :product, {:null=>false}
      foreign_key :photo_id, :photo, {:null=>false}
      column :ordering, Integer, {:null=>false}
    end
  end

  down do
    drop_table(:product_photo)
    drop_table(:product)
  end
end
