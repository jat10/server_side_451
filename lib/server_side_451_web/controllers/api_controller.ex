defmodule ServerSide451Web.ApiController do
  use ServerSide451Web, :controller
  alias ServerSide451.Info.{User, Channel}

 

  def return_available_channels(conn, params) do
  	list_of_channels = ServerSide451.Info.list_channel_detailed
  	message = %{"success" => list_of_channels}

  	conn
    |> json(message)
  end

  def registerUser(conn, %{"channel_id" => channel_id, "user_name" => user_name, "mac_address" => mac_address, "phone_number" => phone_number}) do
  	list_of_user_in_channel = ServerSide451.Info.get_user_by_channel_number(channel_id |> String.to_integer)

  	number_of_users_in_channel = Enum.count(list_of_user_in_channel)


  	channel_avilable = if(number_of_users_in_channel <= 7)do
  		channel = ServerSide451.Info.get_channel_by_channel_number(channel_id)
		user = %{phone_number: phone_number,mac_address: mac_address,user_name: user_name}
		ServerSide451.Info.create_user(channel,user)
  		true
  	else
  		false
  	end
  		

  	message = %{"success" => %{"channel_avilable" => channel_avilable}}
  	conn
    |> json(message)
  end


  def check_user(conn, %{"phone_number" => phone_number}) do
  	user = ServerSide451.Info.get_user_by_phone_number(phone_number)

  	message = case user do
  		nil ->
  			%{"error" => "not found"}
  		_ ->
			%{"success" => 
				%{"channel_id" => user.channel_id, 
				"mac_address" => user.mac_address,
				"phone_number" => user.phone_number,
				"user_name" => user.user_name
				}
			}
  	end

  	conn
    |> json(message)
  end

  def heart_beat(conn, %{"channel_id" => channel_id}) do
  	
  end

  def start_timer(miliseconds) do
  	 case :timer.sleep(miliseconds) do
  	 	:ok -> 
  	 		:ok
  	 end
  end
 
end
