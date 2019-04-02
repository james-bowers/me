defmodule Test.MeWeb.Integration.Role do
  use ExBowers.TestSupport.HTTP, MeWeb.Router
  alias Me.{Role, RoleController}

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
    assert {200, body, _headers} = post("/role/validate", @valid_body)

    assert %{
             "description" => "Role validated",
             "content" => %{
               "role" => %{
                 "person_id" => "c6d771c9-debe-4276-bd32-d2ca2b2c394f",
                 "id" => "f8c8a516-ad0a-4409-aca1-40c74b48d81a",
                 "account_id" => "d75a9cd2-acec-46be-81e7-84a786971d44"
               },
               "person" => %{
                 "last_name" => "Bowers",
                 "id" => "c6d771c9-debe-4276-bd32-d2ca2b2c394f",
                 "first_name" => "James"
               },
               "email" => ["james@ticketbuddy.co.uk"],
               "account" => %{
                 "id" => "d75a9cd2-acec-46be-81e7-84a786971d44",
                 "active" => 1
               }
             }
           } = body
  end

  test "validate an invalid role" do
    assert {400, body, _headers} = post("/role/validate", @invalid_body)

    assert %{
             "description" => "Invalid token",
             "content" => nil
           } = body
  end

  test "when a role is not found" do
    assert {404, body, _headers} = post("/role/validate", @valid_body_but_role_not_found)

    assert %{
             "description" => "Role not found",
             "content" => nil
           } = body
  end

  test "validates role for anonymous user" do
    assert {200, body, _headers} = post("/role/validate", @valid_body_anonymous_user_role_token)

    assert %{
             "description" => "Anonymous user role validated",
             "content" => %{
               "role" => %{
                 "person_id" => "dc54b524-5da1-4120-9871-a57bc814ba05",
                 "id" => "894940b7-8a1c-4ac6-bc03-06f8be64eaa2",
                 "account_id" => "6fb779ee-8215-4873-8275-285dccc12f9f"
               },
               "person" => %{
                 "last_name" => nil,
                 "id" => "dc54b524-5da1-4120-9871-a57bc814ba05",
                 "first_name" => nil
               },
               "account" => %{"id" => "6fb779ee-8215-4873-8275-285dccc12f9f", "active" => 1}
             }
           } = body
  end

  test "links account to person with permission level 0" do
    assert {200, body, _headers} =
             post("/role/link", %{
               account_id: @account3_id,
               person_id: @person2_id
             })

    assert %{
             "description" => "Account linked to person",
             "content" => %{
               "token" => _token,
               "role" => %{
                 "id" => _role_id,
                 "account_id" => "6fb779ee-8215-4873-8275-285dccc12f9f",
                 "person_id" => "dc54b524-5da1-4120-9871-a57bc814ba05",
                 "permission_level" => 0
               }
             }
           } = body
  end

  test "links account to person with permission level 1" do
    assert {200, body, _headers} =
             post("/role/link", %{
               account_id: @account3_id,
               person_id: @person2_id,
               permission_level: 1
             })

    assert %{
             "description" => "Account linked to person",
             "content" => %{
               "token" => _token,
               "role" => %{
                 "id" => _role_id,
                 "account_id" => "6fb779ee-8215-4873-8275-285dccc12f9f",
                 "person_id" => "dc54b524-5da1-4120-9871-a57bc814ba05",
                 "permission_level" => 1
               }
             }
           } = body
  end

  test "invalid request to link (without person_id)" do
    assert {400, body, _headers} =
             post("/role/link", %{
               account_id: @account3_id
             })

    assert %{
             "content" => %{"person_id" => ["can't be blank"]},
             "description" => "Invalid link request"
           } = body
  end

  test "invalid request to link (without account_id)" do
    assert {400, body, _headers} =
             post("/role/link", %{
               person_id: @person2_id
             })

    assert %{
             "content" => %{"account_id" => ["can't be blank"]},
             "description" => "Invalid link request"
           } = body
  end
end
