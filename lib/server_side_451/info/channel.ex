defmodule ServerSide451.Info.Channel do
  use Ecto.Schema
  import Ecto.Changeset
  alias ServerSide451.Info.Channel

   schema "channel" do
    field :channel_number, :string
    field :available_users, :map
    field :master, :string

    timestamps()
  end

  @doc false
  def changeset(%Channel{} = channel, attrs) do
    channel_sigil = ~w(channel_number available_users master)a 

    channel
    |> cast(attrs, channel_sigil)
    |> validate_required(channel_sigil)
  end
end