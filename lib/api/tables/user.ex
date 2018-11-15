defmodule Api.User do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "users" do
    field :id, :integer, primary_key: true, read_after_writes: true
    field :password_hash, :string
    field :phone_number, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :phone_number, :password_hash])
    |> validate_required([:username, :phone_number])
  end
end
