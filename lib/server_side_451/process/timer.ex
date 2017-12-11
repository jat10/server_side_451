defmodule ServerSide451.Process.Timer do
  use GenServer

  def start_link()do
    GenServer.start_link(__MODULE__, [], name: "timer")
  end



end
