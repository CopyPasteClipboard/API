defmodule Api.User do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :created_on, :date
    field :password_hash, :string
    field :phone_number, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :phone_number, :created_on])
    |> validate_required([:username, :password_hash, :phone_number, :created_on])
  end
end
