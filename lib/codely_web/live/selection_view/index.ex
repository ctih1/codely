alias Codely.Snippets

defmodule CodelyWeb.SelectionView.Index do
  use CodelyWeb, :live_view

  def mount(_, _, socket) do
    {vibe_coded_id, codes} = plock_snippet()

    {:ok, assign(socket,
      codes: codes,
      vibe_coded_idx: vibe_coded_id,
      result: nil,
      guessed: false
    )}

  end

  def add_samples() do
    examples = []

    for example <- examples do
      case Snippets.create_snippet(example) do
        {:ok, _} -> :ok
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end

  end

  def plock_snippet() do
    snippet = Snippets.random_snippet()

    IO.inspect({snippet.real_sample, snippet.ai_sample}, label: "plocked samples")

    vibe_coded_id = :rand.uniform(2) - 1

    codes =
      if vibe_coded_id == 1 do
        [snippet.real_sample, snippet.ai_sample]
      else
        [snippet.ai_sample, snippet.real_sample]
      end

    {vibe_coded_id, codes}
  end

  def handle_event("new", _, socket) do
    {vibe_coded_id, codes} = plock_snippet()

    {:noreply,
      assign(socket,
        codes: codes,
        vibe_coded_idx: vibe_coded_id,
        result: nil,
        guessed: false
      )
    }

  end

  def handle_event("guess", %{"idx" => guess}, socket) do
    correct = String.to_integer(guess) == socket.assigns.vibe_coded_idx

    IO.inspect(correct, label: "Is correct?")
    IO.inspect(guess, label: "Guess: ")
    IO.inspect(socket.assigns.vibe_coded_idx, label: "Correct answer: ")

    {:noreply, assign(socket, result: correct, guessed: true)}
  end
end
