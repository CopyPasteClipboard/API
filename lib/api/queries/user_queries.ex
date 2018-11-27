defmodule Api.User.Queries do
    
    alias Api.User
    alias Api.Repo
    import Ecto.Query

    def get_users() do
        Repo.all(User)
    end

    def get_user_by_id(id) do
        Repo.get(User, id)
    end

    def get_user_by_username(username) do
        Repo.get_by(User, username: username)
    end
    
    def create_user(params) do
        User.changeset(%User{}, params)
        |> Repo.insert()
    end

    def update_user_by_ref(old_user, params) do
        User.changeset(old_user, params)
        |> Repo.update!()
    end

    def update_user_by_id(user_id, params) do
        get_user_by_id(user_id)
        |> User.changeset(params)
        |> Repo.update!()
    end

    
end