defmodule ServerSide451Web.ApiController do
  use ServerSide451Web, :controller
  alias ServerSide451.Info.{User, Channel}

 
 	# def return_available_channel(conn, params) do
 	# 	list_of_channels = Channel.list_channels
 	# 	map = Enum.map_reduce(list_of_channels, acc = {%{available_channels: %{}, number: 0}} ,fn(x, acc) -> 
 	# 		map_x = elem(acc,0)

 	# 		case x.available do
 	# 			1 ->
 	# 				values = Map.put(map_x,:available_channels,)
 	# 		end

 	# 	end)
 	# end


end
