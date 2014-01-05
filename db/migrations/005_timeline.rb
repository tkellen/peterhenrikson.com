Sequel.migration do
  up do
    create_table(:timeline) do
      primary_key :id
      column :date_entry, Date, {:null=>false,:default=>:now.sql_function}
      column :title, String, {:null=>false}
      column :body, String
      column :published, TrueFalse {:null=>false,:default=>true}
      index :date_entry
    end
  end

  down do
    drop_table(:timeline)
  end
end
