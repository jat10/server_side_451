defmodule ServerSide451.Info.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ServerSide451.Info.User

   schema "users" do
    field :phone_number, :string
    field :mac_address, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user_sigil = ~w(phone_number mac_address)a 

    user
    |> cast(attrs, user_sigil)
    |> validate_required(user_sigil)
  end
end