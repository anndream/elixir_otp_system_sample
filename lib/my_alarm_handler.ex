defmodule MyAlarmHandler do
  use GenEvent

  def init(args) do
    IO.inspect "*** my_alarm_handler init:"
    IO.inspect args
    {:ok, 0}
  end

  def handle_event({:set_alarm, :tooHot}, n) do
    :error_logger.error_msg("*** Tell the Engineer to turn on the fan~n")
    {:ok, n+1}
  end

  def handle_event({:clear_alarm, :tooHot}, n) do
    :error_logger.error_msg("*** Denger over. Turn off the fan~n")
    {:ok, n}
  end

  def handle_event(event, n) do
    IO.inspect("*** unmatched event:~p~n", [event])
    {:ok, n}
  end

  def handle_call(_request, n) do
    reply = n
    {:ok, reply, n}
  end

  def handle_info(_info, n) do
    {:ok, n}
  end

  def terminate(_reason, _n) do
    :ok
  end
end