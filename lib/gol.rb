require 'set'

class Gol
  def self.parse(argv)
    bool_grid = argv.map do |binary_row|
      binary_row.chars.map { |bin| !bin.to_i.zero? }
    end
    from_bool_grid bool_grid
  end

  def self.from_bool_grid(grid)
    cells = grid.each_with_index.with_object Set.new do |(row, y), set|
      row.each_with_index do |cell, x|
        set << [x, y] if cell
      end
    end
    Gol.new cells
  end

  attr_accessor :cells

  def initialize(cells)
    self.cells = cells
  end

  def to_s width  = cells.max_by { |x, y| x }.first,
           height = cells.max_by { |x, y| y }.last
    height.times.each_with_object "" do |y, string|
      width.times { |x| string << (cells.include?([x, y]) ? 'X' : ' ') }
      string << "\n"
    end
  end

  def alive?(cell)
    cells.include? cell
  end

  def num_neighbours(cell)
    count = 0
    each_neighbour cell do |cell|
      count += 1 if alive? cell
    end
    count
  end

  def alive_tomorrow?(cell)
    n = num_neighbours(cell)
    if alive? cell
      n == 2 || n == 3
    else
      n == 3
    end
  end

  def tomorrow
    pairs = potentially_living.select do |cell|
      alive_tomorrow? cell
    end
    Gol.new(Set.new pairs)
  end

  private

  def potentially_living
    neighbours = []
    cells.each do |cell|
      each_neighbour(cell) { |neighbour| neighbours << neighbour }
    end
    cells | neighbours
  end

  def each_neighbour((y, x))
    yield [y-1, x-1]
    yield [y-1, x]
    yield [y-1, x+1]

    yield [y  , x-1]
    yield [y  , x+1]

    yield [y+1, x-1]
    yield [y+1, x]
    yield [y+1, x+1]
  end
end
