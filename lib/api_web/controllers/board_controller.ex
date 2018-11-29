defmodule ApiWeb.BoardController do
  use ApiWeb, :controller
  alias Api.PasteBoard
  alias Api.BoardItem

  defmodule NotFoundError do
      defexception message: "not found", plug_status: 404
  end

  @doc """
    Handler to create a new board for the user
  """
  def post_board(conn, params) do
    fields = ["user_id", "board_name"]
    params = Map.take(params,fields)

    if length(Map.keys(params)) !== 2 do
      conn 
        |> put_status(:unprocessable_entity)
        |> json(%{ "error" => "must provide username and user_id"})
    else 
      board = PasteBoard.Queries.create_board(params)

      conn
        |>  put_status(:ok)
        |>  json(PasteBoard.render(board))
    end
  end

  @doc """
    Handler to update a new board for the user
  """
  def put_board(conn, params) do
    if !Map.has_key?(params, "board_name") do
      send_resp(conn,:no_content, "")
    else
      id = params["boardId"]
      query = Map.take(["board_name"], params)
      board = PasteBoard.Queries.update_board_by_id(id,query)

      # TODO : add error handling here

      conn
        |>  put_status(:ok)
        |>  json( PasteBoard.render(board) )
    end
  end

  @doc """
    Handler to get items in a particular board
      board is specified in the route parameter :boardId
      and passed into the function inside params
  """
  def get_board(conn, params) do
    
    cond do
      !Map.has_key?(params,"type") ->
        get_most_recent(conn,params)
      params["type"] === "most_recent" ->
        get_most_recent(conn,params)
      params["type"] === "all" ->
        get_all(conn, params)
      true ->
        get_most_recent(conn,params)
    end
  end

  @doc """
    deletes a board from the database
  """
  def delete_board(conn, params) do
    id = params["boardId"]

    # status = PasteBoard.Queries.delete_by_id(id)

    send_resp(conn, :no_content, "")
  end

  def clear_board(conn, params) do
    id = params["boardId"]

    # status = PasteBoard.Queries.clear_board(id)

    send_resp(conn,:no_content, "")
  end

  def post_board_item(conn, params) do
    if !Map.has_key?(params, "board_item") do
      conn
        |> put_status(:unprocessable_entity)
        |> json(%{ "error" => "must provide board_item"})
    else
      new_item = %{ :text_content => params["board_item"],
                    :board_id   =>  params["boardId"]}

      board = BoardItem.Queries.create_item(new_item)

      conn
        |>  put_status(:ok)
        |>  json(BoardItem.render(board))
    end
  end

  #####################################################
  #           Private helpers
  #####################################################

  defp get_most_recent(conn,params) do
    [item | _] = BoardItem.Queries.get_board_items(params["boardId"])
      |> Enum.sort(&(&1.id >= &2.id))

    formattedItem = BoardItem.render(item)

    conn 
      |> put_status(:ok)
      |> json([formattedItem])
  end

  defp get_all(conn,params) do
    items = BoardItem.Queries.get_board_items(params["boardId"])
      |> Enum.map(&BoardItem.render/1)

    conn
      |> put_status(:ok)
      |> json(items)
  end

end
