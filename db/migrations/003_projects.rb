Sequel.migration do
  up do
    create_table(:category) do
      primary_key :id
      column :name, String, {:null=>false}
      index :name, {:unique=>true}
    end
    create_table(:project) do
      primary_key :id
      foreign_key :category_id, :category, {:null=>false}
      column :date_project, Date, {:null=>false,:default=>:now.sql_function}
      column :title, String, {:null=>false}
      column :body, String
      column :url_slug, String, {:null=>false}
      column :published, TrueClass, {:null=>false,:default=>true}
    end
    create_table(:project_photo) do
      primary_key :id
      foreign_key :project_id, :project, {:null=>false}
      column :title, String, {:null=>false}
      column :url, String, {:null=>false}
      column :ordering, Integer, {:null=>false}
    end
  end

  down do
    drop_table(:project_photo)
    drop_table(:project)
    drop_table(:category)
  end
end
