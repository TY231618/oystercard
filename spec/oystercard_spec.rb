require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

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

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#tap_in' do
    it 'allows user to start journey' do
      card = Oystercard.new
      card.top_up(30)
      card.tap_in(entry_station)
      expect(card).to be_in_journey
    end

    it 'prevents user starting journey with balance less than £1' do
      card = Oystercard.new
      expect {card.tap_in(entry_station)}.to raise_error 'Not enough money on card: please top up'
    end

    it 'stores entry station' do
      card = Oystercard.new
      card.top_up(30)
      card.tap_in(entry_station)
      expect(card.entry_station).to eq entry_station
    end
  end

  describe '#tap_out' do
    it 'allows user to end journey' do
      card = Oystercard.new
      card.top_up(30)
      card.tap_in(entry_station)
      card.tap_out(exit_station)
      expect(card.exit_station).to eq exit_station
      #expect(card).not_to be_in_journey
    end

    it 'deducts MIN_FARE on tap_out' do
      card = Oystercard.new
      card.top_up(30)
      card.tap_in(entry_station)
      expect{card.tap_out(exit_station)}.to change{card.balance}.by(-1)
    end
  end

  describe 'journey history' do
    it 'records all previous journeys' do
      card = Oystercard.new
      card.top_up(30)
      card.tap_in(entry_station)
      card.tap_out(exit_station)
      expect(card.journey_history).to eq [entry_station, exit_station]
    end
  end
end
