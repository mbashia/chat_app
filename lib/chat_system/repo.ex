defmodule ChatSystem.Repo do
  use Ecto.Repo,
    otp_app: :chat_system,
    adapter: Ecto.Adapters.MyXQL
end
