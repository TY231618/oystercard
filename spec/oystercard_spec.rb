require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

  describe '#balance' do
    it 'shows the card balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'allows user to add funds to card' do
      expect{oystercard.top_up(20)}.to change{oystercard.balance}.by(20)
    end

    it 'has a max balance of £99' do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      expect {oystercard.top_up(1)}.to raise_error "You have reached your top up limit of £#{Oystercard::MAX_BALANCE}"
    end
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#tap_in' do
    it 'allows user to start journey' do
      oystercard.top_up(30)
      oystercard.tap_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    it 'prevents user starting journey with balance less than £1' do
      expect {oystercard.tap_in(entry_station)}.to raise_error 'Not enough money on card: please top up'
    end

    it 'stores entry station' do
      oystercard.top_up(30)
      oystercard.tap_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end
  end

  describe '#tap_out' do
    it 'allows user to end journey' do
      oystercard.top_up(30)
      oystercard.tap_in(entry_station)
      oystercard.tap_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
      #expect(card).not_to be_in_journey
    end

    it 'deducts MIN_FARE on tap_out' do
      oystercard.top_up(30)
      oystercard.tap_in(entry_station)
      expect{oystercard.tap_out(exit_station)}.to change{oystercard.balance}.by(-1)
    end

    it 'stores exit station' do
      oystercard.top_up(30)
      oystercard.tap_in(entry_station)
      oystercard.tap_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
    end
  end

  describe 'journey history' do
    it 'records all previous journeys' do
      oystercard.top_up(30)
      oystercard.tap_in(entry_station)
      oystercard.tap_out(exit_station)
      expect(oystercard.journey_history).to eq [entry_station, exit_station]
    end
  end
end
