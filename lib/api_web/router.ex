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
        get "/:userid", UserController, :test

        # Gets the user’s clipboards
        get "/:userid/clipboards", UserController, :test

        # Creates a new user
        post "/:userid", UserController, :test

        # Updates a :userid’ profile information
        put "/:userid", UserController, :test

        # Deletes a user from the database
        delete "/:userid", UserController, :test
      end

      scope "/clipboard" do
        # Creates a new clipboard for the user
        post "/:boardId", BoardController, :test

        # Edits the clipboard (say, the clipboard name)
        put "/:boardId", BoardController, :test

        # Gets all items currently in the clipboard
        # needs parameters
        # ?type=mostRecent || type=all
        get "/:boardId", BoardController, :test

        # deletes the associated clipboard
        delete "/:boardId", BoardController, :test

        # Clears the clipboard
        delete "/:boardID/clear", BoardController, :test

        # Adds an item to the clipboard
        post "/:boardId/boarditem", BoardController, :test
      end

      scope "/boarditem" do
        # Gets the item associated with itemID
        get "/:itemID", ItemController, :test

        # Removes the board item associated with itemID
        delete "/:itemID", ItemController, :test
      end

    end
  end
end
