defmodule Test.MeWeb.Integration.Login do
  use BowersLib.TestSupport.HTTP, MeWeb.Router

  @valid_body %{email: "james@ticketbuddy.co.uk", password: "password"}

  test "a user can login" do
    assert {200, body,
            [
              {"cache-control", "max-age=0, private, must-revalidate"},
              {"content-type", "application/json; charset=utf-8"}
            ]} = post("/person/login", @valid_body)

    assert %{
             "content" => %{
               "claims" => %{
                 "expires" => _expires
               },
               "token" => _token
             }
           } = body
  end
end
