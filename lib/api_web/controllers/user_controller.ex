defmodule ApiWeb.UserController do
    use ApiWeb, :controller

    defmodule NotFoundError do
        defexception message: "not found", plug_status: 404
    end

    def get_user(conn, params) do
        id = params["userid"]
        user = Api.User.Queries.get_user_by_id(id)

        if !user do raise(NotFoundError) end

        conn
            |> put_status(:ok)
            |> json(user)
    end
  
    def get_user_boards(conn, params) do
        id = params["userid"]
        boards = Api.PasteBoard.Queries.get_boards_for_user(id)

        if boards === [] do raise(NotFoundError) end

        conn 
            |> put_status(:ok)
            |> json( boards )
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

            # TODO: add error handling here

            conn
                |> put_status(:ok)
                |> json(%{ :username => user.username, :id => user.id })
        end
    end

    def put_user(conn, params) do
        id = params["userid"]
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

        # status = Api.User.Queries.delete_user_by_id(id)

        send_resp(conn,204, "")
    end
end