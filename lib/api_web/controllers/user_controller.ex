defmodule ApiWeb.UserController do
    use ApiWeb, :controller
  
    def getUser(conn, _params) do
        json conn, ["getUser"]
    end
  
    def getUserBoards(conn, _params) do
        json conn, ["getUsersClipboards"]
    end

    def postUser(conn, _params) do
        json conn, ["postUser"]
    end

    def putUser(conn, _params) do
        json conn, ["putUser"]
    end

    def deleteUser(conn, _params) do
        json conn, ["deleteUser"]
    end
end