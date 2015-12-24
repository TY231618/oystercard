require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'shows the card balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'allows user to add funds to card' do
      card = Oystercard.new
      expect{card.top_up(20)}.to change{card.balance}.by(20)
    end
  end
end
