defmodule AreaServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def area(thing) do
    GenServer.call(__MODULE__, {:area, thing})
  end

  def init([]) do
    Process.flag(:trap_exit, true)
    IO.inspect("#{__MODULE__} starting\n")
    {:ok, 0}
  end

  def handle_call({:area, thing}, _from, n) do
    {:reply, compute_area(thing), n+1}
  end

  def handle_cast(_msg, n) do
    {:noreply, n}
  end

  def handle_info(_info, n) do
    {:noreply, n}
  end

  def terminate(_reason, _n) do
    IO.inspect("#{__MODULE__} stopping\n")
  end

  def code_change(_old_vsn, n, _extra) do
    {:ok, n}
  end

  defp compute_area({:square, x}) do
    x * x
  end
  defp compute_area({:rectangle, x, y}) do
    raise "oops!!"
  end
end