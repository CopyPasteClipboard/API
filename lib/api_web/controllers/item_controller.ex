defmodule ApiWeb.ItemController do
    use ApiWeb, :controller
  
    def getItem(conn, _params) do
        json conn, ["getItem"]
    end

    def deleteItem(conn, _params) do
        json conn, ["deleteItem"]
    end
  
end