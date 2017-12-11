defmodule ServerSide451.Info do
	import Ecto.Query, warn: false
  	alias ServerSide451.Repo
  	alias ServerSide451.Info.{User, Channel}

	def create_user(%Channel{} = channel, attrs \\ %{}) do
		if (channel.available == 0) do
			user = %User{}
			|> User.changeset(attrs)
			|> Ecto.Changeset.put_change(:channel_id, channel.channel_number)
		    |> Repo.insert() 
		else 
			{:error, "Channel is not available"}
		end
		
	end

	def get_user_by_phone_number(phone_number) do
		User
    	|> Repo.get_by(phone_number: phone_number)
	end

	def get_user_by_channel_number(channel_number) do
		from(u in User, where: u.channel_id == ^channel_number) 
	    |> select([u], u.phone_number)
	    |> Repo.all
	end

	def get_number_of_users_in_channel(channel_number) do
		list = get_user_by_channel_number(channel_number) |> Enum.count
	end

	def update_user(%User{} = user, attrs) do
		user
		|> User.changeset(attrs)
		|> Repo.update()
	end

	def create_channel(attrs \\ %{}) do
		%Channel{}
		|> Channel.changeset(attrs)
		|> Repo.insert()
	end

	def get_channel_by_channel_number(channel_number) do
		Channel
    	|> Repo.get_by(channel_number: channel_number)
	end

	def update_channel(%Channel{} = channel , attrs) do
		channel
		|> Channel.changeset(attrs)
		|> Repo.update()
	end

	def list_channels do
		from(c in Channel, where: c.available > -1) 
	    |> select([c], 
	    	%{channel_number: c.channel_number,
	    	available: c.available, number_of_users: 0})
	    |> Repo.all

	end

	def list_channel_detailed do
		list = list_channels
		list |> Enum.map(fn x -> 
			channel_number = x.channel_number
			number_of_users = get_number_of_users_in_channel(channel_number)
			map = x |> Map.put(:number_of_users,number_of_users)
		end)
	end

	def create_channels do
		[1,2,3,4,5] |> Enum.each(fn(x) ->
  			 %{channel_number: x, available: 0, master: 0}
  		 	 |> create_channel
		end)
	end

end
