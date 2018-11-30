defmodule ApiWeb.UserController do
    use ApiWeb, :controller
    alias Api.PasteBoard
    alias Api.User

    defmodule NotFoundError do
        defexception message: "not found", plug_status: 404
    end

    def get_user(conn, params) do
        id = params["user_id"]
        user = User.Queries.get_user_by_id(id)

        if !user do raise(NotFoundError) end
        
        conn
            |> put_status(:ok)
            |> json( User.render(user))
    end
  
    def get_user_boards(conn, params) do
        id = params["user_id"]
        boards = PasteBoard.Queries.get_boards_for_user(id) 
            |> Enum.map(&PasteBoard.render/1)

        if boards === [] do raise(NotFoundError) end

        conn 
            |> put_status(:ok)
            |> json(boards)
    end

    def post_user(conn, params) do
        fields = ["username", "password", "phone_number"]
        params = Map.take(params,fields)

        if length(Map.keys(params)) !== 3 do
            conn
                |> put_status(:unprocessable_entity)
                |> json(%{ "error" => "must provide username, password, and phone_number"})
        else
            # for now, assume all fields are valid
            {status, user} = User.Queries.create_user(params)

            board_params = %{ :board_name => "default", :user_id => user.id }
            _ = PasteBoard.Queries.create_board( board_params )

            conn
                |> put_status(status)
                |> json(User.render(user))
        end
    end

    def put_user(conn, params) do
        id = params["user_id"]
        query = params["phone_number"]

        if !query do
            send_resp(conn,204, "")
        else
            user = User.Queries.update_user_by_id(id, %{ "phone_number" => query })

            conn 
                |> put_status(:ok)
                |> json(User.render(user))
        end
    end

    def delete_user(conn, params) do
        id = params["username"]

        # will cause compiler error about id being undefined for now
        # status = User.Queries.delete_user_by_id(id)

        send_resp(conn,204, "")
    end
end