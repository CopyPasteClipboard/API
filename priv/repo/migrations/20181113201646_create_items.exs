defmodule Api.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text_content, :string
      add :created_on, :date
      add :board_id, references(:boards, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:items, [:board_id])
  end
end
