defmodule Pesto.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pesto.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"
  def parse_username(email) do
    email
    |> String.split("@")
    |> Enum.at(0, "")
  end

  def valid_user_attributes(attrs \\ %{}) do
    email = unique_user_email()
    Enum.into(attrs, %{
      email: email,
      username: parse_username(email),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Pesto.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
