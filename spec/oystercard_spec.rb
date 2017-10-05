require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  it "#balance should return 0 as a default when Oystercard is initialised" do
    expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  it "#top_up should change the balance on the Oystercard" do
    expect{ oystercard.top_up(10)}.to change{oystercard.balance}.by(10)
  end

  it '#balance should not exceed £90' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up(maximum_balance)
    expect { oystercard.top_up(1)}.to raise_error('You have exceeded card limit')
  end

  it{ is_expected.to respond_to(:touch_in).with(1).argument }

  it 'should have an empty list of journey by default' do
    expect(oystercard.journey).to eq Oystercard::EMPTY_JOURNEY
  end

context '£5 on oystercard' do
  before(:each)do
   oystercard.top_up(5)
  end

  it 'in the beginning, it is not in journey' do
  expect(oystercard.in_journey?).to be false
  end

  it 'tells if a passenger is in journey or not' do
    expect(oystercard.in_journey?).to eq(true).or(eq(false))
  end

  it 'tracks if a passenger is in journey' do
    oystercard.touch_in(entry_station)
    expect(oystercard.in_journey?).to be true
    oystercard.touch_out(exit_station)
    expect(oystercard.in_journey?).to be false
  end

  it 'should deduct from balance when touch_out' do
    expect{oystercard.touch_out(exit_station) }.to change{subject.balance}.by(-(Oystercard::MINIMUM_FARE))
  end

  it 'remembers entry station when touch_in' do
    oystercard.touch_in(entry_station)
    expect(oystercard.entry_station).to eq(entry_station)
  end

  it 'remembers exit station when touch_out' do
    oystercard.touch_out(exit_station)
    expect(oystercard.exit_station).to eq(exit_station)
  end
end

context 'touched in and out' do
  before(:each)do
   oystercard.top_up(5)
   oystercard.touch_in(entry_station)
   oystercard.touch_out(exit_station)
  end

  it 'forgets entry station when touch_out' do
    expect(oystercard.entry_station).to eq nil
  end

  it 'records one journey when user touch_in, followed by touch_out' do
    expect(oystercard.journey.count).to eq(1)
end

  it 'records both entry and exit stations in journey array' do
    expect(oystercard.journey).to eq([{entry: entry_station, exit: exit_station}])
  end
end

context 'balance zero' do
  it 'raises an error when tries to touch in when fund insufficient' do
    expect{oystercard.touch_in(entry_station)}.to raise_error('insufficient fund')
  end
end

end
