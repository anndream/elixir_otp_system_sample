defmodule PrimeServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def new_prime(n) do
    GenServer.call(__MODULE__, {:prime, n}, 20000)
  end

  def init([]) do
    Process.flag(:trap_exit, true)
    IO.inspect("#{__MODULE__} starting\n")
    {:ok, 0}
  end

  def handle_call({:prime, k}, _from, n) do
    {:reply, make_new_prime(k), n+1}
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

  defp make_new_prime(k) do
    if k > 100 do
      :alarm_handler.set_alarm(:tooHot)
      n = :lib_primes.make_prime(k)
      :alarm_handler.clear_alarm(:tooHot)
      n
    else
      :lib_primes.make_prime(k)
    end
  end
end