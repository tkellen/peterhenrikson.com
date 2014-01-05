Sequel.migration do
  up do
    create_table(:photo) do
      primary_key :id
      column :title, String, {:null=>false}
      column :ext, String, {:null=>false,:default=>'.jpg'}
      column :upload_stamp, DateTime, {:null=>false,:default=>:now.sql_function}
    end
  end

  down do
    drop_table(:photo)
  end
end
