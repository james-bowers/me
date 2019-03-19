defmodule Test.MeWeb.Integration.Status do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router

  @opts Router.init([])

  test "/status" do
    conn = conn(:get, "/status")
    conn = Router.call(conn, @opts)

    assert {
             200,
             [
               {"cache-control", "max-age=0, private, must-revalidate"},
               {"content-type", "text/plain; charset=utf-8"}
             ],
             ~s(OK)
           } = sent_resp(conn)
  end
end
