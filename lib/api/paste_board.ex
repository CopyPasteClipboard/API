defmodule Api.PasteBoard do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "boards" do
    field :board_name, :string
    field :created_on, :date
    field :user_id, :binary_id
    field :most_recent_item, :binary_id

    timestamps()
  end

  @doc false
  def changeset(paste_board, attrs) do
    paste_board
    |> cast(attrs, [:board_name, :created_on])
    |> validate_required([:board_name, :created_on])
  end
end
