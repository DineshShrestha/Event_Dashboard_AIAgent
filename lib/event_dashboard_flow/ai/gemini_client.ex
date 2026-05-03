defmodule EventDashboardFlow.AI.GeminiClient do
  @url "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"

  def ask(prompt) do
    api_key = System.fetch_env!("GEMINI_API_KEY")

    body = %{
      contents: [
        %{
          parts: [
            %{text: prompt}
          ]
        }
      ]
    }

    case Req.post("#{@url}?key=#{api_key}", json: body) do
      {:ok, %{status: status, body: %{"error" => error}}} ->
        {:error, "Gemini error #{status}: #{error["message"]}"}

      {:ok, %{status: status, body: body}} when status in 200..299 ->
        {:ok, get_text(body)}

      {:ok, %{status: status, body: body}} ->
        {:error, "HTTP #{status}: #{inspect(body)}"}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  defp get_text(%{
         "candidates" => [
           %{
             "content" => %{
               "parts" => [
                 %{"text" => text} | _
               ]
             }
           }
           | _
         ]
       }) do
    text
  end

  defp get_text(body), do: "Unexpected Gemini response: #{inspect(body)}"
end
