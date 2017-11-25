defmodule ServerSide451.Info.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ServerSide451.Info.User

   schema "users" do
    field :phone_number, :string
    field :mac_address, :string
    field :user_name, :string
    belongs_to :channel, Channel


    # x = %{phone_number: "03890388",mac_address: "ABCC-XXXX",user_name: "Jad"}
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user_sigil = ~w(phone_number mac_address user_name)a 

    user
    |> cast(attrs, user_sigil)
    |> validate_required(user_sigil)
  end
end

