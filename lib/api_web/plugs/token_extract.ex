defmodule TokenExtract do
    @moduledoc """
    A plug to extract the token from the header of an HTTP request
    """
    defmodule UnauthorizedError do
        @moduledoc """
        Error raised by the module when the user could not
        be authenticated.
        """
    
        defexception message: "unauthorized", plug_status: 401
    end
    
    # For all plugs, the init/1 and call/2 methods are required
    def init(options), do: options

    def call(conn, _opts) do
        token = get_token(conn)
        Map.put(conn, :token, token)
    end

    defp get_token(conn) do 
        # can't find a better way to do this, still learning how to work with keyword lists
        # headers are stored in conn.req_headers = [ { :header, value}, ....]
        auth = Enum.filter(conn.req_headers, fn { key, _ } -> key === "authorization" end )

        if auth === [] do
            raise(UnauthorizedError)
        end

        # get the token
        [{ _ , token }]  = auth
        [_, token] = String.split(token)
        token
    end
end