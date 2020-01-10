defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
    # Map.put(image, :color, {r, g, b})
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  defp mirrow_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
