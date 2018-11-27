defmodule ApiWeb.UserController do
    use ApiWeb, :controller

    defmodule NotFoundError do
        defexception message: "not found", plug_status: 404
    end

    def get_user(conn, params) do
        id = params["user_id"]
        user = Api.User.Queries.get_user_by_id(id)

        if !user do raise(NotFoundError) end

        IO.inspect user
        conn
            |> put_status(:ok)
            |> json( %{ :id => user.id, :phone_number => user.phone_number, :username => user.username, :created=> user.inserted_at})
    end
  
    def get_user_boards(conn, params) do
        id = params["user_id"]
        boards = Api.PasteBoard.Queries.get_boards_for_user(id) 
            |> Enum.map(fn x -> %{:id => x.id, :board_name => x.board_name, :inserted_at => x.inserted_at} end)

        if boards === [] do raise(NotFoundError) end

        value = conn 
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
            {status, user} = Api.User.Queries.create_user(params)

            board_params = %{ :board_name => "default", :user_id => user.id }
            board = Api.PasteBoard.Queries.create_board( board_params )

            conn
                |> put_status(:ok)
                |> json(%{ :username => user.username, :id => user.id })
        end
    end

    def put_user(conn, params) do
        id = params["user_id"]
        query = params["phone_number"]

        if !query do
            send_resp(conn,204, "")
        else
            status = Api.User.Queries.update_user_by_id(id, %{ "phone_number" => query })

            ret = %{ :id => status.id, :phone_number => status.phone_number, 
                        :created => status.updated_at}

            json conn, ret
        end
    end

    def delete_user(conn, params) do
        id = params["username"]

        # will cause compiler error about id being undefined for now
        # status = Api.User.Queries.delete_user_by_id(id)

        send_resp(conn,204, "")
    end
end