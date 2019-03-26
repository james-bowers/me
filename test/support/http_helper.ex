defmodule Test.Support.HTTPHelper do
  use Plug.Test
  alias MeWeb.Router

  @opts Router.init([])

  def post(endpoint, body \\ %{}) do
    conn = conn(:post, endpoint, body)
    conn = Router.call(conn, @opts)

    {
      status,
      _headers,
      body
    } = sent_resp(conn)

    {status, Poison.decode!(body)}
  end
end
