defmodule Sellaprime do
  use Application

  def start(_type, start_args) do
    SellaprimeSupervisor.start_link(start_args)
  end

  def stop(_state) do
    :ok
  end
end