defmodule Api.PasteBoard.Queries do
    alias Api.PasteBoard
    alias Api.User
    alias Api.Repo
    import Ecto.Query
    
    def get_board_by_id(id) do
        Repo.get(PasteBoard, id)
    end

    def get_boards_for_user(user_id) do
        IO.inspect user_id
        from(b in PasteBoard)
        |> where([b], b.user_id == ^user_id)
        |> Repo.all()
    end

    def create_board(params) do
        PasteBoard.changeset(%PasteBoard{}, params)
        |> Repo.insert!()
    end

    def update_board_by_id(board_id, params) do
        get_board_by_id(board_id)
        |> PasteBoard.changeset(params)
        |> Repo.update!()
    end

    def update_board_by_ref(board, params) do
        PasteBoard.changeset(board, params)
        |> Repo.update!()
    end
end