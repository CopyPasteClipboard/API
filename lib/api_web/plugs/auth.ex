defmodule Auth do
    @moduledoc """
    A plug to provide authentication protection.
    """
    defmodule UnauthorizedError do
        @moduledoc """
        Error raised by the module when the user could not
        be authenticated.
        """
    
        defexception message: "unauthorized", plug_status: 401
    end
    
    def init(options), do: options

    def call(conn, opts) do
        # TODO: Add authorization logic here
        conn
    end


  end
  