defmodule ServerSide451Web.ApiController do
  use ServerSide451Web, :controller
  alias ServerSide451.Info.{User, Channel}

 

  def return_available_channels(conn, params) do
  	list_of_channels = ServerSide451.Info.list_channel_detailed
  	message = %{"success" => list_of_channels}

  	conn
    |> json(message)
  end

  def registerUser(conn, %{"channel_id" => channel_id, "user_name" => user_name, "mac_address" => mac_address, "phone_number" => phone_number , "ip_address" => ip_address}) do
  	name = "channel:"<>channel_id |> String.to_atom
  	list_of_user_in_channel = ServerSide451.Info.get_user_by_channel_number(channel_id |> String.to_integer)

  	number_of_users_in_channel = Enum.count(list_of_user_in_channel)

  	{channel_avilable,state} = case number_of_users_in_channel do
  		0 ->
  			{true,"master"}
  		1 -> 
  			ServerSide451.Process.Timer.start(channel_id)
  			{true,"slave"}
  		7 ->
  			GenServer.cast(name,:stop_timer)
  			{false,""}
  		_ ->
  			if(number_of_users_in_channel <= 7) do
  				{true,"slave"}
  			else
  				{false,""}
  			end
  	end

  	if(channel_avilable == true) do
  		channel = ServerSide451.Info.get_channel_by_channel_number(channel_id)
		user = %{phone_number: phone_number,mac_address: mac_address,user_name: user_name, ip_address: ip_address,state: state}
		ServerSide451.Info.create_user(channel,user)
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
  	 name = "channel:"<>channel_id |> String.to_atom
  	 response = GenServer.call(name,:get_time)

  	 message = case response.time_ended do
  	 	true ->
  	 		slaves = ServerSide451.Info.get_slaves(channel_id)
  	 		master = ServerSide451.Info.get_master(channel_id)
  	 		 %{"success" =>
  	 		  %{"master" => 
  	 		 	%{"master_id" => master.id,
  	 		  	"master_ip_address" => master.ip_address,
  	 		  	 "master_phone" => master.phone_number
  	 		  	 },
  	 		  "slaves" => slaves,
  	 		  "state" => "timer-off"

  	 		}}
  	 	false ->
  	 		 %{"success" =>
  	 		  %{"master" => 
  	 		 	%{},
  	 		  "slaves" => [],
  	 		  "state" => "timer-on"
  	 		}}
  	 		
  	 end

  	conn
    |> json(message)

  end
end
