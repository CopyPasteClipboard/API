defmodule Api.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :serial, primary_key: true
      add :username, :string
      add :password_hash, :string
      add :phone_number, :string

      timestamps()
    end

  end
end
