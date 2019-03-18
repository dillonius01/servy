defmodule Recurse do
  def triple([head | tail]) do
    [head * 3 | triple(tail)]
  end

  def triple([]), do: []

  def map([head | tail], func) do
    [func.(head) | map(tail, func)]
  end

  def map([], _func), do: []
end
