require 'gol'

RSpec.describe 'acceptance' do
  it 'receives the board, parses it, and prints each state with a pause between them' do
    # parse the args into a board
    board = Gol.parse ['000', '111', '000']

    # represent the board as a string
    expect(board.to_s 3, 3).to eq "   \n" +
                                  "XXX\n" +
                                  "   \n"

    # iterate the board
    board = board.tomorrow

    # represent the board as a string
    expect(board.to_s 3, 3).to eq " X \n" +
                                  " X \n" +
                                  " X \n"

    # iterate the board
    board = board.tomorrow

    # represent the board as a string
    expect(board.to_s 3, 3).to eq "   \n" +
                                  "XXX\n" +
                                  "   \n"
  end
end
