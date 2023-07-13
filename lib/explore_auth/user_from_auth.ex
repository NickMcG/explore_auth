defmodule ExploreAuth.UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth response.

  This file is adapted from the [Ueberauth Example](https://github.com/ueberauth/ueberauth_example/blob/master/lib/ueberauth_example/user_from_auth.ex)
  """
  require Logger
  require Jason

  alias Ueberauth.Auth

  defstruct [:auth_type, :auth_id, :email, :name, :avatar_url]

  def extract_info(%Auth{} = auth) do
    %__MODULE__{
      auth_type: auth.provider,
      auth_id: auth.uid,
      email: auth.info.email,
      name: extract_name(auth),
      avatar_url: extract_avatar_url(auth)
    }
  end

  ###### Private implementation

  # Some do it this way
  defp extract_avatar_url(%{info: %{urls: %{avatar_url: image}}}), do: image

  # Others do it this way
  defp extract_avatar_url(%{info: %{image: image}}), do: image

  # default case if nothing matches
  defp extract_avatar_url(auth) do
    Logger.warn("#{auth.provider} needs to find an avatar URL!")
    Logger.debug(Jason.encode!(auth))
    nil
  end

  defp extract_name(auth) do
    if auth.info.name do
      auth.info.name
    else
      name = [auth.info.first_name, auth.info.last_name] |> Enum.filter(&(&1 != nil && &1 != ""))

      if Enum.empty?(name) do
        auth.info.nickname
      else
        Enum.join(name, " ")
      end
    end
  end
end
