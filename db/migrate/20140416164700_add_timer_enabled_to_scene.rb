# See http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html
Sequel.migration do
  change do
    alter_table(:scenes) do
      add_column :timer_enabled, :boolean, :default => false, :null => false
    end
  end
end
