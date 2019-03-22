defmodule Test.Me.PersonModel do
  use ExUnit.Case
  use Plug.Test

  alias Me.{Person, Password, PersonModel}

  @person1_id "c6d771c9-debe-4276-bd32-d2ca2b2c394f"

  test "gets a person by person id" do
    person = PersonModel.get(%Person{id: @person1_id})

    assert %Person{
             id: @person1_id,
             email: [
               %Me.Email{
                 email: "james@ticketbuddy.co.uk"
               }
             ],
             password: %Password{
               password_hash: "$2b$12$w/ygPaYlXRhzubnAj/7.xueZQpqbGmbTQ4OrzHaaY90Rma7MBkKVG"
             }
           } = person
  end

  test "gets a person by email" do
    person = PersonModel.get_by_email("james@ticketbuddy.co.uk")

    assert %Person{
             id: @person1_id,
             email: [
               %Me.Email{
                 email: "james@ticketbuddy.co.uk"
               }
             ],
             password: %Password{
               password_hash: "$2b$12$w/ygPaYlXRhzubnAj/7.xueZQpqbGmbTQ4OrzHaaY90Rma7MBkKVG"
             }
           } = person
  end
end
