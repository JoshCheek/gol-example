require 'gol'

RSpec.describe 'rules' do
  def board_for(alive, neighbours)
    cells = Set.new [
      [0,0], [1,0], [2,0],
      [0,1],        [2,1],
      [0,2], [1,2], [2,2],
    ].take(neighbours)
    cells << [1,1] if alive
    board = Gol.new(cells)

    # sanity checking
    expect(board.num_neighbours [1, 1]).to eq neighbours
    expect(board.alive? [1, 1]).to eq alive

    board
  end


  def assert_dies(alive:, neighbours:)
    board = board_for alive, neighbours
    expect(board.tomorrow.alive? [1, 1]).to eq false
  end

  def assert_lives(alive:, neighbours:)
    board = board_for alive, neighbours
    expect(board.tomorrow.alive? [1, 1]).to eq true
  end

  specify 'live cells with fewer than two live neighbours die (ie under-population)' do
    assert_dies alive: true, neighbours: 0
    assert_dies alive: true, neighbours: 1
  end

  specify 'live cells with two or three live neighbours stay alive' do
    assert_lives alive: true, neighbours: 2
    assert_lives alive: true, neighbours: 3
  end

  specify 'live cells with more than three live neighbours die (ie overcrowding)' do
    assert_dies alive: true, neighbours: 4
    assert_dies alive: true, neighbours: 5
    assert_dies alive: true, neighbours: 6
    assert_dies alive: true, neighbours: 7
    assert_dies alive: true, neighbours: 8
  end

  specify 'dead cells with exactly three live neighbours come to life (ie reproduction)' do
    assert_dies  alive: false, neighbours: 0
    assert_dies  alive: false, neighbours: 1
    assert_dies  alive: false, neighbours: 2

    assert_lives alive: false, neighbours: 3

    assert_dies  alive: false, neighbours: 4
    assert_dies  alive: false, neighbours: 5
    assert_dies  alive: false, neighbours: 6
    assert_dies  alive: false, neighbours: 7
    assert_dies  alive: false, neighbours: 8
  end
end
