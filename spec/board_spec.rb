require_relative "./spec_helper"

describe Board do

  let(:board) {Board.new}

  describe "#move_valid?" do 

    it "returns true if the chosen column isn't full" do
    end
  end

  describe "#tie?" do

    it "returns false if the board ism't full" do
      expect(board.tie?).to be false
    end
  end
end