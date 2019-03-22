defmodule Test.MeWeb.Integration.Role do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router
  alias Me.{Role, RoleController}

  @opts Router.init([])

  @valid_role %Role{
    id: "f8c8a516-ad0a-4409-aca1-40c74b48d81a",
    account_id: "d75a9cd2-acec-46be-81e7-84a786971d44",
    person_id: "c6d771c9-debe-4276-bd32-d2ca2b2c394f",
    permission_level: 0,
    inserted_at: ~N[2019-03-20 19:26:39],
    updated_at: ~N[2019-03-20 19:26:39]
  }
  {:ok, token, _claims} = RoleController.sign(@valid_role)

  @valid_body %{
    token: token
  }

  @invalid_body %{
    token: "an invalid token"
  }

  test "validate a valid role" do
    conn = conn(:post, "/role/validate", @valid_body)
    conn = Router.call(conn, @opts)

    assert {200, _headers,
            ~s({"description":"Role validated","content":{"role":{"person_id":"c6d771c9-debe-4276-bd32-d2ca2b2c394f","id":"f8c8a516-ad0a-4409-aca1-40c74b48d81a","account_id":"d75a9cd2-acec-46be-81e7-84a786971d44"}}})} =
             sent_resp(conn)
  end

  test "validate an invalid role" do
    conn = conn(:post, "/role/validate", @invalid_body)
    conn = Router.call(conn, @opts)

    assert {400, _headers,
            ~s({"description":"Invalid token","content":null})} =
             sent_resp(conn)
  end
end
