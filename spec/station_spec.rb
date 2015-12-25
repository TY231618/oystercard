require 'station'

describe Station do
  subject(:station) {described_class.new('Tooting', 3)}

  it 'returns the name of the station' do
    expect(station.name).to eq 'Tooting'
  end

  it 'returns the zone of the station' do
    expect(station.zone).to eq 3
  end
end
