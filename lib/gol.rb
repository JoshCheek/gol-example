require 'set'

class Gol
  def self.parse(argv)
    new(argv.each_with_index.with_object(Set.new) { |(row, y), cells|
      row.each_char.with_index { |bin, x| cells << [x, y] unless bin.to_i.zero? }
    })
  end

  attr_accessor :cells

  def initialize(cells)
    self.cells = cells
  end

  def to_s(w, h)
    (w*h).times.each.with_object("")
         .map { |n, s| alive?([n%w, n/w]) ? "X" : " " }
         .join.gsub(/(.{#{w}})/, "\\1\n")
  end

  def alive?(cell)
    cells.include? cell
  end

  def num_neighbours(cell)
    neighbours_of(cell).count { |cell| alive? cell }
  end

  def alive_tomorrow?(cell)
    n = num_neighbours(cell)
    n == 3 || (n == 2 && alive?(cell))
  end

  def tomorrow
    Gol.new Set.new potentially_living.select { |cell| alive_tomorrow? cell }
  end

  private

  def potentially_living
    cells | cells.flat_map { |cell| neighbours_of cell }
  end

  def neighbours_of((y, x))
    [ [y-1, x-1], [y-1, x], [y-1, x+1],
      [y  , x-1],           [y  , x+1],
      [y+1, x-1], [y+1, x], [y+1, x+1],
    ]
  end
end
