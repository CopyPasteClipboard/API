defmodule Api.BoardItem do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "items" do
    field :id, :integer, primary_key: true, read_after_writes: true
    field :text_content, :string
    field :board_id, :integer

    timestamps()
  end

  @all_fields [:text_content, :board_id]
  
  @doc false
  def changeset(board_item, attrs) do
    board_item
    |> cast(attrs, @all_fields)
    |> validate_required(@all_fields)
  end
end
