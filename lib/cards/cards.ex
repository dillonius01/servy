defmodule Cards do
  def generate_deck do
    ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    suits = ["♣", "♦", "♥", "♠"]
    for rank <- ranks, suit <- suits, do: {rank, suit}
  end

  def deal_random do
    generate_deck()
    |> Enum.take_random(13)
  end

  def deal_four_hands do
    generate_deck()
    |> Enum.shuffle()
    |> Enum.chunk_every(13)
  end
end
