Sequel.migration do
  up do
    create_table(:page_seo) do
      primary_key :id
      column :url, String, {:null=>false}
      column :title, String, {:null=>false}
      column :description, String
      index :url
    end
  end

  down do
    drop_table(:page_seo)
  end
end
