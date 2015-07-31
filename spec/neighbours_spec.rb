require 'gol'

RSpec.describe 'neighbours' do
  def assert_neighbours(num_neighbours, xy_living)
    board = Gol.new Set.new(xy_living)
    expect(board.num_neighbours [1, 1]).to eq num_neighbours
  end

  it 'counts the number of living cells around a given position (horizontal, vertical, diagonal)' do
    assert_neighbours 0, [                         [1,1],                        ]
    assert_neighbours 1, [                         [1,1],                   [2,2]]
    assert_neighbours 2, [                         [1,1],             [1,2],[2,2]]
    assert_neighbours 3, [                         [1,1],       [0,2],[1,2],[2,2]]
    assert_neighbours 5, [                   [0,1],[1,1],[2,1], [0,2],[1,2],[2,2]]
    assert_neighbours 6, [            [2,0], [0,1],[1,1],[2,1], [0,2],[1,2],[2,2]]
    assert_neighbours 7, [      [1,0],[2,0], [0,1],[1,1],[2,1], [0,2],[1,2],[2,2]]
    assert_neighbours 8, [[0,0],[1,0],[2,0], [0,1],[1,1],[2,1], [0,2],[1,2],[2,2]]
  end

  it 'considers cells neighbouring the borders to be dead' do
    cells = Set.new [
      [0, 0], [1, 0], [2, 0],
      [0, 1], [1, 1], [2, 1],
      [0, 2], [1, 2], [2, 2],
    ]

    # corners have 3 neighbours
    [[0, 0], [0, 2], [2, 0], [2, 2]].each do |cell|
      expect(Gol.new(cells).num_neighbours cell).to eq 3
    end

    # middle have 5 neighbours
    [[0, 1], [1, 0], [1, 2], [2, 1]].each do |cell|
      expect(Gol.new(cells).num_neighbours cell).to eq 5
    end
  end
end
