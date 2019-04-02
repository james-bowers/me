defmodule MeWeb.Router do
  use Plug.Router
  use Plug.Debugger

  alias Me.{PersonRoute, RoleRoute}

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
    |> send_resp(200, ~s({"status": "ok"}))
  end

  forward("/person", to: PersonRoute)
  forward("/role", to: RoleRoute)
end
