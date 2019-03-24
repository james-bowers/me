defmodule Me.PersonRoute do
  use Plug.Router
  use Plug.Debugger

  alias Me.{PersonController}
  alias MeWeb.{PersonView}

  plug(:match)
  plug(:dispatch)

  post "/login" do
    PersonController.login(%{
      password: conn.params["password"],
      email: conn.params["email"]
    })
    |> PersonView.render(:login, conn)
  end

  post "/sign-up" do
    PersonController.sign_up(%{
      password: conn.params["password"],
      email: conn.params["email"]
    })
    |> PersonView.render(:sign_up, conn)
  end
end
