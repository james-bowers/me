defmodule MeWeb.Router do
  use Plug.Router
  use Plug.Debugger

  alias Me.{AccountRoute, PersonRoute, RoleRoute}

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  get "/status" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "OK")
  end

  forward("/person", to: PersonRoute)
  forward("/account", to: AccountRoute)
  forward("/role", to: RoleRoute)
end
