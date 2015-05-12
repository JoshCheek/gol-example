module Gol
  def self.parse(argv)
    cells = argv.map do |binary_row|
      binary_row.chars.map { |bin| !bin.to_i.zero? }
    end

    Board.new(cells)
  end

  class Board
    attr_accessor :cells

    def initialize(cells)
      self.cells = cells
    end

    def to_s
      cells.map { |row|
        chars = row.map { |cell| cell ? 'X' : ' ' }
        chars.join << "\n"
      }.join
    end

    def alive?(y, x)
      cells[y][x]
    end

    def num_neighbours(y, x)
      [ [y-1, x-1], [y-1, x], [y-1, x+1],
        [y  , x-1],           [y  , x+1],
        [y+1, x-1], [y+1, x], [y+1, x+1],
      ].count { |y, x| in_bounds?(y, x) && alive?(y, x) }
    end

    def in_bounds?(y, x)
      0 <= y && 0 <= x && y < cells.length && y < cells.first.length
    end

    def alive_tomorrow?(y, x)
      n = num_neighbours(y, x)
      if alive? y, x
        n == 2 || n == 3
      else
        n == 3
      end
    end

    def tomorrow
      new_cells = cells.map.with_index do |row, y|
        row.each_index.map { |x| alive_tomorrow? y, x }
      end
      Board.new(new_cells)
    end
  end
end
