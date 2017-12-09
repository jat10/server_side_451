defmodule ServerSide451Web.ApiController do
  use ServerSide451Web, :controller
  alias ServerSide451.Info.{User, Channel}

 

  def return_available_channels(conn, params) do
  	list_of_channels = ServerSide451.Info.list_channels
  	message = %{"success" => list_of_channels}

  	conn
    |> json(message)
  end

  def registerUser(%{"channel_id" => channel_id, "user_name" => user_name, "mac_address" => mac_address, "phone_number" => phone_number}) do
  	list_of_user_in_channel = ServerSide451.Info.get_user_by_channel_number(channel_id)

  	number_of_users_in_channel = Enum.count(list_of_user_in_channel)

  	{master,channel_avilable} = case number_of_users_in_channel do
  		0 ->
  			{1,"true"}
  		1 ->
  			{0, "true"}
  			case start_timer(60000) do
  				:ok ->

  			end

	  	7 ->
	  		#The next user will make the channel not available
	  		{0, "false"}
	  	_ ->

  	end
  		
 	channel = ServerSide451.Info.get_channel_by_channel_number(channel_id)
	user = %{phone_number: phone_number,mac_address: mac_address,user_name: user_name}
	ServerSide451.Info.create_user(channel,user)
  
  end

  def start_timer(miliseconds) do
  	 case :timer.sleep(miliseconds) do
  	 	:ok -> 
  	 		:ok
  	 end
  end
 
end
