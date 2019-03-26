defmodule Test.MeWeb.Integration.Role do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router
  alias Me.{Role, RoleController}

  @opts Router.init([])

  @role1_id "f8c8a516-ad0a-4409-aca1-40c74b48d81a"
  @role2_id "894940b7-8a1c-4ac6-bc03-06f8be64eaa2"
  @person2_id "dc54b524-5da1-4120-9871-a57bc814ba05"
  @account3_id "6fb779ee-8215-4873-8275-285dccc12f9f"

  @valid_role %Role{
    id: @role1_id,
    account_id: "d75a9cd2-acec-46be-81e7-84a786971d44",
    person_id: "c6d771c9-debe-4276-bd32-d2ca2b2c394f",
    permission_level: 0,
    inserted_at: ~N[2019-03-20 19:26:39],
    updated_at: ~N[2019-03-20 19:26:39]
  }
  {:ok, token, _claims} = RoleController.sign(@valid_role)

  {:ok, role_not_found_token, _claims} =
    RoleController.sign(Map.put(@valid_role, :id, "1cb6865a-b44d-40df-a0dc-f2249e38b54f"))

  {:ok, anonymous_user_role_token, _claims} =
    RoleController.sign(
      @valid_role
      |> Map.put(:id, @role2_id)
      |> Map.put(:account_id, @account3_id)
      |> Map.put(:person_id, @person2_id)
    )

  @valid_body %{
    token: token
  }

  @invalid_body %{
    token: "an invalid token"
  }

  @valid_body_but_role_not_found %{
    token: role_not_found_token
  }

  @valid_body_anonymous_user_role_token %{
    token: anonymous_user_role_token
  }

  test "validate a valid role" do
    conn = conn(:post, "/role/validate", @valid_body)

    conn = Router.call(conn, @opts)

    assert {200, _headers,
            ~s({"description":"Role validated","content":{"role":{"person_id":"c6d771c9-debe-4276-bd32-d2ca2b2c394f","id":"f8c8a516-ad0a-4409-aca1-40c74b48d81a","account_id":"d75a9cd2-acec-46be-81e7-84a786971d44"},"person":{"last_name":"Bowers","id":"c6d771c9-debe-4276-bd32-d2ca2b2c394f","first_name":"James"},"email":["james@ticketbuddy.co.uk"],"account":{"id":"d75a9cd2-acec-46be-81e7-84a786971d44","active":1}}})} =
             sent_resp(conn)
  end

  test "validate an invalid role" do
    conn = conn(:post, "/role/validate", @invalid_body)
    conn = Router.call(conn, @opts)

    assert {400, _headers, ~s({"description":"Invalid token","content":null})} = sent_resp(conn)
  end

  test "when a role is not found" do
    conn = conn(:post, "/role/validate", @valid_body_but_role_not_found)
    conn = Router.call(conn, @opts)

    assert {404, _headers, ~s({"description":"Role not found","content":null})} = sent_resp(conn)
  end

  test "validates role for anonymous user" do
    conn = conn(:post, "/role/validate", @valid_body_anonymous_user_role_token)

    conn = Router.call(conn, @opts)

    assert {200, _headers,
            ~s({"description":"Anonymous user role validated","content":{"role":{"person_id":"dc54b524-5da1-4120-9871-a57bc814ba05","id":"894940b7-8a1c-4ac6-bc03-06f8be64eaa2","account_id":"6fb779ee-8215-4873-8275-285dccc12f9f"},"person":{"last_name":null,"id":"dc54b524-5da1-4120-9871-a57bc814ba05","first_name":null},"account":{"id":"6fb779ee-8215-4873-8275-285dccc12f9f","active":1}}})} =
             sent_resp(conn)
  end
end
