defmodule KeyLearningWeb.Api.SessionController do
  use KeyLearningWeb, :controller

  def create(conn, %{"email" => nil}) do
    status_not_be_authenticated(conn)
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case KeyLearning.Accounts.get_user_by_email_and_password(email, password) do
      %KeyLearning.Accounts.User{} = user ->
        {:ok, jwt, _claims} = KeyLearning.Guardian.encode_and_sign(user, %{})

        conn
        |> render("created.json", user: user, jwt: jwt)

      nil -> status_not_be_authenticated(conn)
    end
  end

  defp status_not_be_authenticated(conn) do
    conn
    |> put_status(401)
    |> render("error.json", message: "You could not be authenticated.")
  end
end
