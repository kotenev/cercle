defmodule CercleApi.GuardianErrorHandler do
  import Plug.Conn
  import CercleApi.Router.Helpers

  def unauthenticated(conn, _params) do
    conn
    |> Plug.Conn.put_session(:redirect_url, __MODULE__.redirect_url(conn))
    |> Phoenix.Controller.put_flash(:error, "You must be logged in to access that page.")
    |> Phoenix.Controller.redirect(to: session_path(conn, :new))
  end


  def redirect_url(conn) do
    case conn.query_string do
      "" -> conn.request_path
      _ -> Enum.join([conn.request_path, conn.query_string], "?")
    end
  end
end
