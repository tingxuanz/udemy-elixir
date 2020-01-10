defmodule Cards do
  @moduledoc """
    handle a deck of cards
  """
  def hello do
    :world
  end

  @doc """
    generate a deck
  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamond"]

    # list comprehension
    # comprehension is a mappping function
    for suit <- suits, value <- values do # every possible combination of suits and values
        "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    # { status, binary } = File.read(filename)
    # case status do
    #   :ok -> :erlang.binary_to_term binary
    #   :error -> "That file does not exist"
    # end
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} ->
        "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    # first argument of methods must be consistent
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size) # |> inject 1st argument automatically
  end
end
