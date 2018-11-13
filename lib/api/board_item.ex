defmodule Api.BoardItem do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "items" do
    field :created_on, :date
    field :text_content, :string
    field :board_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(board_item, attrs) do
    board_item
    |> cast(attrs, [:text_content, :created_on])
    |> validate_required([:text_content, :created_on])
  end
end
