defmodule Api.BoardItem.Queries do
    
    import Ecto.Query
    alias Api.BoardItem
    alias Api.Repo
    alias Api.User
    alias Api.PasteBoard

    def get_item_by_id(id) do
        Repo.get(BoardItem, id)
    end

    def get_all_items() do
        Repo.all(BoardItem)
    end

    def get_board_items(board_id) do
        from(i in BoardItem)
        |> where([i], i.board_id == ^board_id)
        |> Repo.all()
    end
    
    def get_user_items(user_id) do
        from(i in BoardItem)
        |> join(
            :inner, 
            [i], 
            b in subquery(from(b in PasteBoard) |> where([b], b.user_id == ^user_id)), 
            on: b.id == i.board_id)
        |> Repo.all()
    end
    
    def create_item(params) do
        BoardItem.changeset(%BoardItem{}, params)
        |> Repo.insert!()
    end

    def update_item_by_id(id, params) do
        get_item_by_id(id)
        |> BoardItem.changeset(params)
        |> Repo.update!()
    end

    def update_item_by_ref(item, params) do
        BoardItem.changeset(item, params)
        |> Repo.update!()
    end
end