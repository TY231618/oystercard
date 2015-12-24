require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'shows the card balance' do
      expect(subject.balance).to eq 0
    end
  end

end
