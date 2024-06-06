defmodule PestoWeb.WrongLive do
  use PestoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess",
       time: time(),
       num: random_num()
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score <%= @score %></h1>
    <h2>
      <%= @message %> It's <%= @time %>
    </h2>
    <br />
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2
      px-4 border border-blue-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}
        >
          <%= n %>
        </.link>
      <% end %>
      <br />
      <pre>
        <%= @current_user.username || @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end

  def random_num() do
    :rand.uniform(10)
  end

  @impl true
  def handle_event("guess", %{"number" => guess}, socket) do
    correct_guess = String.to_integer(guess) == socket.assigns.num

    case correct_guess do
      true ->
        message = "Your guess is right. Answer is #{socket.assigns.num}"
        score = socket.assigns.score + 1

        {:noreply,
         assign(socket, score: score, message: message, time: time(), num: random_num())}

      false ->
        message = "Your guess is wrong. Correct answer is #{socket.assigns.num}"
        score = socket.assigns.score - 1

        {:noreply,
         assign(socket, score: score, message: message, time: time(), num: random_num())}
    end
  end
end
