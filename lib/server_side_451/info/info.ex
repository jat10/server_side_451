defmodule ServerSide451.Info do
	import Ecto.Query, warn: false
  	alias ServerSide451.Repo
  	alias ServerSide451.Info.{User, Channel}

	def create_user(attrs \\ %{}) do
		%User{}
		|> User.changeset(attrs)
		|> Repo.insert()
	end

	def get_user_by_phone_number(phone_number) do
		User
    	|> Repo.get_by(phone_number: phone_number)
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

end
