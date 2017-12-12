defmodule ServerSide451.Process.Timer do
  use GenServer

  def start(channel_id)do
    name = "channel:"<>channel_id |> String.to_atom
    GenServer.start_link(__MODULE__, %{timestamp: :os.timestamp(), time_ended: false}, name: name)
  end

   # GenServer.start_link(ServerSide451.Process.Timer, %{timestamp: :os.timestamp()}, name: "timer:1")

  def handle_call(:get_time, _from,state) do
    if(:timer.now_diff(:os.timestamp(),state.timestamp) >= 120000000) do
      state = Map.put(state,:time_ended, true)
      {:reply, state,state}
    else
      {:reply, state,state}
    end
  end

   def handle_cast(:stop_timer, state) do
      {:stop, :shutdown, state}
  end

end
