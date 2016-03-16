defmodule SellaprimeSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    GenEvent.swap_handler(:alarm_handler, :alarm_handler, :swap, MyAlarmHandler, :xyz)

    children = [
      worker(AreaServer, [], [id: :tag1,
                              restart: :permanent,
                              shutdown: 10000,
                              function: :start_link,
                              modules: [:area_server]]),
      worker(PrimeServer, [], [id: :tag2,
                               restart: :permanent,
                               shutdown: 10000,
                               function: :start_link,
                               modules: [:prime_server]])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
