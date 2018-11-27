defmodule ApiWeb.BoardController do
  use ApiWeb, :controller

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
        |> json(%{ "error" => "must provide username and userid"})
    else 
      board = Api.PasteBoard.Queries.create_board(params)

      conn
        |>  put_status(:ok)
        |>  json(%{ :id => board.id, :board_name => board.board_name })
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
      board = Api.PasteBoard.Queries.update_board_by_id(id,query)

      # TODO : add error handling here

      conn
        |>  put_status(:ok)
        |>  json( %{ "board_name" => board.board_name} )
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

    # status = Api.PasteBoard.Queries.delete_by_id(id)

    send_resp(conn, :no_content, "")
  end

  def clear_board(conn, params) do
    id = params["boardId"]

    # status = Api.PasteBoard.Queries.clear_board(id)

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

      status = Api.BoardItem.Queries.create_item(new_item)
      IO.inspect status

      conn
        |>  put_status(:ok)
        |>  json(%{ :new_item => status.text_content })
    end
  end

  #####################################################
  #           Private helpers
  #####################################################

  defp get_most_recent(conn,params) do
    IO.puts "get_most_recent"
    json conn, params
  end

  defp get_all(conn,params) do
    items = Api.BoardItem.Queries.get_board_items(params["boardId"])


    # items = Enum.sort(items, fn (item1, item2) -> 

    # end)
    json conn, params
  end

end
