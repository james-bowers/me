defmodule MeWeb.View do
  import Plug.Conn
  
  @enforce_keys [:description, :content]
  defstruct [:description, :content]

  def send_json(conn, status, %__MODULE__{} = content) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(content))
  end
end