defmodule ApiWeb.ItemController do
    use ApiWeb, :controller
    alias Api.BoardItem

    defmodule NotFoundError do
        defexception message: "not found", plug_status: 404
    end

    def get_item(conn, params) do
        id = params["itemID"]

        item = BoardItem.Queries.get_item_by_id(id)

        if !item do
            raise(NotFoundError)
        end

        conn
            |> put_status(:ok)
            |> json(BoardItem.render(item))
    end

    def delete_item(conn, params) do
        id = params["itemID"]

        # status = Api.BoardItem.Queries.delete_item_by_id(id)

        send_resp(conn, :no_content, "")
    end
end