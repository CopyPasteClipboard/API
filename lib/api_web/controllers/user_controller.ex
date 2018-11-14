defmodule ApiWeb.UserController do
    use ApiWeb, :controller
  
    def index(conn, _params) do
      IO.inspect conn
      IO.inspect conn.resp_headers
      users = []
      json conn, users
    end
  
    def postTest(conn, _params) do
      users = []
      json conn, users
    end
  
    def test(conn, _params) do
      users = [ "hello"]
      json conn, users
    end
  
end