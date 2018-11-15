defmodule Api.PasteBoard do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "boards" do
    field :id, :integer, primary_key: true, read_after_writes: true
    field :user_id, :integer
    field :board_name, :string

    timestamps()
  end

  @all_fields [:board_name, :user_id]

  @doc false
  def changeset(paste_board, attrs) do
    paste_board
    |> cast(attrs, @all_fields)
    |> validate_required(@all_fields)
  end
end
