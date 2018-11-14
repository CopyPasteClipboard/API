defmodule ApiWeb.Router do
  use ApiWeb, :router


  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", ApiWeb do
    pipe_through :api

    scope "/v1" do
      scope "/user" do
        # Gets the user’s profile information 
        get "/:userid", UserController, :getUser

        # Gets the user’s clipboards
        get "/:userid/clipboards", UserController, :getUserBoards

        # Creates a new user
        post "/:userid", UserController, :postUser

        # Updates a :userid’ profile information
        put "/:userid", UserController, :putUser

        # Deletes a user from the database
        delete "/:userid", UserController, :deleteUser
      end

      scope "/clipboard" do
        # Creates a new clipboard for the user
        post "/:boardId", BoardController, :postBoard

        # Edits the clipboard (say, the clipboard name)
        put "/:boardId", BoardController, :putBoard

        # Gets all items currently in the clipboard
        # needs parameters
        # ?type=mostRecent || type=all
        get "/:boardId", BoardController, :getBoard

        # deletes the associated clipboard
        delete "/:boardId", BoardController, :deleteBoard

        # Clears the clipboard
        delete "/:boardID/clear", BoardController, :clearBoard

        # Adds an item to the clipboard
        post "/:boardId/boarditem", BoardController, :postBoardItem
      end

      scope "/boarditem" do
        # Gets the item associated with itemID
        get "/:itemID", ItemController, :getItem

        # Removes the board item associated with itemID
        delete "/:itemID", ItemController, :deleteItem
      end

    end
  end
end
