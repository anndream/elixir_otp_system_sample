defmodule EventHandler do
  def make(name) do
    Process.register(spawn(fn -> my_handler(&no_op/1) end), name)
  end

  def add_handler(name, fun) do
    send(name, {:add, fun})
  end

  def event(name, x) do
    send(name, {:event, x})
  end

  defp my_handler(fun) do
    receive do
      {:add, fun1} -> my_handler(fun1)
      {:event, any} ->
        try do
          fun.(any)
          my_handler(fun)
        catch
          _e -> :exit
        end
    end
  end

  defp no_op(_) do
    :void
  end
end
