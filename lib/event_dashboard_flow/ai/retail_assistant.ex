defmodule EventDashboardFlow.AI.RetailAssistant do
  alias EventDashboardFlow.AI.GeminiClient
  alias EventDashboardFlow.DashboardState

  def explain(question) do
    dashboard = EventDashboardFlow.DashboardState.get_status()

    prompt = """
    You are a retail diagnostics assistant.

    Flag meanings:
    - STORE_OPEN false means the store is closed
    - TERMINAL_ACTIVE false means terminal is inactive
    - DOOR_LOCKED true means door is locked
    - door_open false means door is closed

    Rules:
    - Use only given data
    - Be specific
    - Do not guess
    - Return JSON only

    Format:
    {
    "status": "",
    "reason": "",
    "details": []
    }

    Data:
    #{Jason.encode!(dashboard)}

    Question:
    #{question}
    """

    case EventDashboardFlow.AI.GeminiClient.ask(prompt) do
      {:ok, answer} -> answer
      {:error, reason} -> "AI error: #{reason}"
    end
  end
end
