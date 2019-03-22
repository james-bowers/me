defmodule Me.RoleRoute do
  use Plug.Router
  use Plug.Debugger

  alias Me.{RoleController}
  alias MeWeb.{RoleView}

  plug(:match)
  plug(:dispatch)

  post "/validate" do
    RoleController.validate(conn.params["token"])
    |> case do
      {:ok, claims} ->
        RoleController.fetch_resource(claims)
        |> RoleView.render(:validate, conn)

      {:error, reason} ->
        RoleView.render({:error, reason}, :validate, conn)
    end

    # conn
    # |> put_resp_content_type("text/plain")
    # |> send_resp(200, "OK")
  end
end
