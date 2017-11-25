defmodule ServerSide451.Info.Channel do
  use Ecto.Schema
  import Ecto.Changeset
  alias ServerSide451.Info.{Channel, User}

   schema "channel" do
    field :channel_number, :integer
    field :available, :integer
    field :master, :integer
    timestamps()
  end

  #y = %{channel_number: 1,available: 0, master: 0}
  @doc false
  def changeset(%Channel{} = channel, attrs) do
    channel_sigil = ~w(channel_number available master)a 

    channel
    |> cast(attrs, channel_sigil)
    |> validate_required(channel_sigil)
  end
end