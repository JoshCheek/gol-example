require 'gol'

RSpec.describe 'neighbours' do
  def assert_neighbours(num_neighbours, cells)
    board = Gol::Board.new(cells)
    expect(board.num_neighbours 1, 1).to eq num_neighbours
  end

  it 'counts the number of living cells around a given position (horizontal, vertical, diagonal)' do
    assert_neighbours 0, [[false, false, false], [false, :cell, false], [false, false, false]]
    assert_neighbours 1, [[false, false, false], [false, :cell, false], [false, false,  true]]
    assert_neighbours 2, [[false, false, false], [false, :cell, false], [false,  true,  true]]
    assert_neighbours 3, [[false, false, false], [false, :cell, false], [ true,  true,  true]]
    assert_neighbours 5, [[false, false, false], [ true, :cell,  true], [ true,  true,  true]]
    assert_neighbours 6, [[false, false,  true], [ true, :cell,  true], [ true,  true,  true]]
    assert_neighbours 7, [[false,  true,  true], [ true, :cell,  true], [ true,  true,  true]]
    assert_neighbours 8, [[true,   true,  true], [ true, :cell,  true], [ true,  true,  true]]
  end


  it 'considers cells neighbouring the borders to be dead' do
    cells = [[true,   true,  true], [ true, true,  true], [ true,  true,  true]]

    # corners have 3 neighbours
    [[0, 0], [0, 2], [2, 0], [2, 2]].each do |y, x|
      board = Gol::Board.new(cells)
      expect(board.num_neighbours y, x).to eq 3
    end

    # middle have 5 neighbours
    [[0, 1], [1, 0], [1, 2], [2, 1]].each do |y, x|
      board = Gol::Board.new(cells)
      expect(board.num_neighbours y, x).to eq 5
    end
  end
end
