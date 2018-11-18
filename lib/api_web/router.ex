defmodule ApiWeb.Router do
  use ApiWeb, :router
  alias Auth
  alias TokenExtract
  use Plug.ErrorHandler

  pipeline :api do
    plug :accepts, ["json"]
    plug(TokenExtract)
    plug(Auth)
  end

  # routes begin here
  scope "/v1", ApiWeb do
    pipe_through :api

    # user routes 
    get "/user/:userid", UserController, :getUser
    get "/user/:userid/clipboards", UserController, :getUserBoards
    post "/user", UserController, :postUser
    put "/user/:userid", UserController, :putUser
    delete "/user/:userid", UserController, :deleteUser

    # clipboard routes
    post "/clipboard", BoardController, :postBoard
    put "/clipboard/:boardId", BoardController, :putBoard

    # ?type=mostRecent || type=all
    get "/clipboard/:boardId", BoardController, :getBoard
    delete "/clipboard/:boardId", BoardController, :deleteBoard
    delete "/clipboard/:boardID/clear", BoardController, :clearBoard
    post "/clipboard/:boardId/boarditem", BoardController, :postBoardItem

    # boarditem
    get "/boarditem/:itemID", ItemController, :getItem
    delete "/boarditem/:itemID", ItemController, :deleteItem
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