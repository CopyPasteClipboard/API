defmodule Api.Repo.Migrations.UpdateBoards do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add :most_recent_item, references(:items, on_delete: :nothing, type: :binary_id)  
    end
    
    create index(:boards, [:most_recent_item])
  end
end
