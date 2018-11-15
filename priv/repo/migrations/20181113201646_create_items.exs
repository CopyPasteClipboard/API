defmodule Api.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :serial, primary_key: true
      add :text_content, :string
      add :board_id, references(:boards, on_delete: :nothing, type: :bigint)

      timestamps()
    end

    create index(:items, [:board_id])
  end
end
