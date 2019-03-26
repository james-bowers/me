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
    signup_params(conn)
    |> PersonController.sign_up()
    |> PersonView.render(:sign_up, conn)
  end

  defp signup_params(conn) do
    case conn.params do
      %{"password" => _password, "email" => _email} ->
        %{
          password: conn.params["password"],
          email: conn.params["email"]
        }

      _ ->
        %{}
    end
  end
end
