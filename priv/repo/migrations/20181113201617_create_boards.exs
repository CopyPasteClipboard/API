defmodule Api.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards, primary_key: false) do
      add :id, :serial, primary_key: true
      add :board_name, :string
      add :user_id, references(:users, on_delete: :nothing, type: :bigint)

      timestamps()
    end

    create index(:boards, [:user_id])
  end
end
