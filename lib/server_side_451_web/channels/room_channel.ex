 defmodule ServerSide451Web.RoomChannel do
  use Phoenix.Channel
  require Logger

  alias HTTPoison

  def join("channel:" <> checkout_id, message, socket) do
 
      send(self(), :track)
      send(self(), {:after_join, message})
      send(self(), {:init, message})
      {:ok, socket}     
  end

  # Presence
  def handle_info(:track, socket) do
    {:noreply, socket}
  end

  def handle_info({:after_join, msg}, socket) do
    # broadcast! socket, "user:entered", %{user: msg["user"]}
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  def handle_info({:init, msg}, socket) do
       broadcast! socket, "msg", %{msg: "You are connected to the channel congrats"}
       {:noreply,socket}
  end

  def handle_in("get_list",msg,socket) do
      push socket,"return_list", %{list: "list"}
      {:noreply,socket}
  end

  
end