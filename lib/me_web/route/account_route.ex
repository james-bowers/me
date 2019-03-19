defmodule Me.AccountRoute do
  use Plug.Router
  use Plug.Debugger

  alias Me.{AccountController, Account}
  alias MeWeb.{AccountView}

  plug(:match)
  plug(:dispatch)

  post "/" do
    AccountController.insert()
    |> AccountView.render(:new_account, conn)
  end
end