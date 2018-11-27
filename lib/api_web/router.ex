defmodule ApiWeb.Router do
  use ApiWeb, :router
  alias Auth
  alias TokenExtract
  use Plug.ErrorHandler

  pipeline :api do
    plug :accepts, ["json"]
    # plug(TokenExtract)
    # plug(Auth)
  end

  # routes begin here
  scope "/v1", ApiWeb do
    pipe_through :api

    # user routes 
    get "/user/:userid", UserController, :get_user
    get "/user/:userid/clipboards", UserController, :get_user_boards
    post "/user", UserController, :post_user
    put "/user/:userid", UserController, :put_user
    delete "/user/:userid", UserController, :delete_user

    get "/user/:username", UserController, :get_user_by_username

    # clipboard routes
    post "/clipboard", BoardController, :post_board
    put "/clipboard/:boardId", BoardController, :put_board

    # ?type=mostRecent || type=all
    get "/clipboard/:boardId", BoardController, :get_board
    delete "/clipboard/:boardId", BoardController, :delete_board
    delete "/clipboard/:boardId/clear", BoardController, :clear_board
    post "/clipboard/:boardId/boarditem", BoardController, :post_board_item

    # boarditem
    get "/boarditem/:itemID", ItemController, :get_item
    delete "/boarditem/:itemID", ItemController, :delete_item
  end

  # this, combined with the Plug.ErrorHandler allows for custom errors to be easily sent 
  def handle_errors(conn, %{kind: _kind, reason: reason, stack: _stack}) do
    if Map.has_key?(reason, :message) do
      json conn, %{ "error" => reason.message }
    else
      json conn, [reason]
    end
  end

end   # end module