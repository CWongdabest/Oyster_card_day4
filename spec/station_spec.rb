require 'station'

describe Station do

subject(:station) { described_class.new(name, zone)}
let(:name) {double :name}
let(:zone) {double :zone}


it {is_expected.to respond_to(:info)}

it 'is expected to display station name info as required' do
  expect(station.info[:name]).to eq(name)
end

it 'is expected to display station zone info as required' do
  expect(station.info[:zone]).to eq(zone)
end

end
