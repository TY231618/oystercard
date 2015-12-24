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

    it 'has a max balance of £99' do
      card = Oystercard.new
      card.top_up(Oystercard::MAX_BALANCE)
      expect {card.top_up(1)}.to raise_error "You have reached your top up limit of £#{Oystercard::MAX_BALANCE}"
    end
  end
end
