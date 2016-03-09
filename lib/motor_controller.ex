defmodule MotorController do
  def add_event_handler do
    EventHandler.add_handler(:errors, &controller/1)
  end

  defp controller(:too_hot) do
    IO.inspect "Turn off the motor-m"
  end
  defp controller(x) do
    IO.inspect "#{__MODULE__} ignored event: #{x}"
  end
end