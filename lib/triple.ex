defmodule Servy.Triple do
  def triple([head | tail]) do
    [head * 3 | triple(tail)]
  end

  def triple([]), do: []
end
