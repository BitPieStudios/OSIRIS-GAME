# See http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html
Sequel.migration do
  change do
    create_table :scenes do
      primary_key :id
      integer :parent_id
      string :title, :null => false
      text :body, :null => false
      datetime :created_at, :null => false
      datetime :updated_at, :null => false
    end
  end
end